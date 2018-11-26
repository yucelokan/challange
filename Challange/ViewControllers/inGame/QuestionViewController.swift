//
//  QuestionViewController.swift
//  Challange
//
//  Created by Okan Yücel on 26.11.2018.
//  Copyright © 2018 Okan Yücel. All rights reserved.
//

import UIKit

protocol isEverythingOkayDelegate{
    func isEverythingOkay(isOkay: Bool)
}

public enum statusOfUser{
    case player, isViewer, waitingForWildCard, waitingForNewQuestion, waitingForAnswers
}

class QuestionViewController: UIViewController, isEverythingOkayDelegate{
    
    init(question: Question, userInfo: UserInformation) {
        self.mQuestion = question
        self.mUserInformation = userInfo
        super.init(nibName: "QuestionViewController", bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var alreadyUseWildCard = false
    var userStatus = statusOfUser.player
    var isEverythingOkay = true
    func isEverythingOkay(isOkay: Bool) {
        self.isEverythingOkay = isOkay
    }
    
    
    @IBOutlet weak var mTableView: UITableView!
    
    var counter = 10
    var timer = Timer()
    var questionNum = 1
    var mQuestion: Question?
    var mUserInformation: UserInformation?
    var selectedAnswer:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mTableView.register(QuestionTableViewCell.classForCoder(), forCellReuseIdentifier: "QuestionTableViewCell")
        self.mTableView.register(UINib.init(nibName: "QuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionTableViewCell")
        
        self.mTableView.register(AnswerTableViewCell.classForCoder(), forCellReuseIdentifier: "AnswerTableViewCell")
        self.mTableView.register(UINib.init(nibName: "AnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "AnswerTableViewCell")
        
        // ilk açılışta cevaplar varsa yükleme yap.
        if let _ = self.mQuestion?.cevaplar{
            self.userStatus = .player
            self.mTableView.reloadData()
            self.startTimer()
        }
        
    }
    
}

extension QuestionViewController{
    
    func getNextQuestion(){
        
        self.questionNum += 1
        
        guard let _ = self.mQuestion?.soruSira, let toplam = self.mQuestion?.toplamSoru else{
            return
        }
        
        guard questionNum <= toplam else{
          self.finishCompetition()
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            CompetitionManager.instance.setAllDefaultBackground(tableView: self.mTableView)
            self.getQuestion(questionNumParameter: self.questionNum)
        }
        
    }
    
    func getQuestion(questionNumParameter: Int){
        RequestManager.instance.getQuestion(questionNumber: questionNumParameter) { (status, result) in
            if status{
                self.selectedAnswer = nil
                if self.userStatus == .waitingForNewQuestion{
                    self.userStatus = .player
                }
                self.mQuestion = result
                self.mTableView.reloadData()
                self.startTimer()
            }
        }
    }
    
    func startTimer(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startCountDown), userInfo: nil, repeats: true)
        }
    }
    
    @objc func startCountDown(){
        
        guard let cell = self.mTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? QuestionTableViewCell else{
            return
        }
        
        cell.mLabelTime.text = "\(self.counter)"
        
        self.counter -= 1
        
        if counter == -1{
            self.counter = 10
            self.timer.invalidate()
            if CompetitionManager.instance.checkAnswer(selectedAnswer: self.selectedAnswer, correctAnswer: self.mQuestion?.dogruCevap, tableView: self.mTableView){
                self.userStatus = .waitingForNewQuestion
                self.getNextQuestion()
            }else{
                if alreadyUseWildCard {
                    self.userStatus = .isViewer
                    self.getNextQuestion()
                    
                    if let topVC = HelperManager.topViewController(){
                        let message = "Wild-Card hakkınızı zaten kullandınız!"
                         AlertManager.instance.showNegativeMessage(message: message, time: 2, controller: topVC)
                    }

                }else if self.userStatus != .isViewer{
                   self.userStatus = .waitingForWildCard
                   self.askUserWildCard()
                }else{
                    self.getNextQuestion()
                }
                
            }
        }
        
    }
    
    func setAnswer(tableView tableViewParameter: UITableView?, cell cellParameter: AnswerTableViewCell?, indexPath indexPathParaemeter: IndexPath?){

        guard let cell = cellParameter else{
            return
        }
        
        self.selectedAnswer = cell.mLabelAnswer.text
        CompetitionManager.instance.setAnswerBackground(type: .waiting, cell: cell)
        self.userStatus = .waitingForAnswers

    }

    func askUserWildCard(){
        guard let cardNum = self.mUserInformation?.wildCardCount, cardNum > 0 else{
            return
        }
        
        let title = "10"
        let message = "ACELE ET! Yarışmaya devam edebilmek için wild card kullan!"
        let buttonString = "KULLAN"
        
        var count = 10
        
        AlertManager.instance.showAlert(title: title, message: message, type: .alert, buttonString: buttonString, showCancel: true) {
            
            self.alreadyUseWildCard = true
            self.userStatus = .waitingForNewQuestion
            self.mUserInformation?.wildCardCount = (self.mUserInformation?.wildCardCount ?? 0) - 1
            let messageToast = "Kart kullanıldı."
            AlertManager.instance.showPositiveMessage(message: messageToast, time: 3, controller: self)
    
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            
            AlertManager.instance.changeAlertText(title: true, newText: "\(count)")
            count -= 1
            
            if count == -1{
                if self.userStatus == .waitingForWildCard{
                    self.userStatus = .isViewer
                    let messageToast = "İzleyici olarak devam edilecek!"
                    AlertManager.instance.showNegativeMessage(message: messageToast, time: 3, controller: self)
                }
                
                self.getNextQuestion()
                AlertManager.instance.dismissAlert()
                timer.invalidate()
            }
        })
        
        
    }
    
    func finishCompetition(){
        let final = FinalViewController()
        present(final, animated: true, completion: nil)
    }
    
    
}

extension QuestionViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRows = 0
        
        if let _ = self.mQuestion?.soru{
            numberOfRows += 1
        }
        
        if let cevaplarNum = self.mQuestion?.cevaplar?.count{
            numberOfRows += cevaplarNum
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell", for: indexPath) as? QuestionTableViewCell
            
            cell?.isEverythingOkayDelegate = self
            cell?.question = self.mQuestion
            cell?.userInformation = self.mUserInformation
            
            return cell ?? UITableViewCell.init(frame: CGRect.zero)
        }else{
            let selectedAnswer = self.mQuestion?.cevaplar?[indexPath.row - 1]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerTableViewCell", for: indexPath) as? AnswerTableViewCell
            
            cell?.isEverythingOkayDelegate = self
            cell?.answer = selectedAnswer
            
            return cell ?? UITableViewCell.init(frame: CGRect.zero)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard self.isEverythingOkay else{
            return
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? AnswerTableViewCell else{
            return
        }
        
        switch self.userStatus {
        case .isViewer:
            
            let title = "İzleyicisiniz!"
            let message = "Sorulara cevap veremezsiniz. Yarışmadan çıkmak ister misiniz?"
            let buttonString = "Evet"
            AlertManager.instance.showAlert(title: title, message: message, type: .alert, buttonString: buttonString, showCancel: true) {
                self.dismiss(animated: false, completion: nil)
            }
            
            break
        case .waitingForNewQuestion:
            
            let title = "Yeni soru için bekleniyor"
            let message = "Lütfen yeni sorunun gelmesini bekleyin."
            let buttonString = "Tamam"
            AlertManager.instance.showAlert(title: title, message: message, type: .alert, buttonString: buttonString, showCancel: false) { }
            
            break
        case .waitingForWildCard:
            break
        case .waitingForAnswers:
            
            let title = "Daha süre var!"
            let message = "Lütfen sürenin bitmesini bekleyin."
            let buttonString = "Tamam"
            AlertManager.instance.showAlert(title: title, message: message, type: .alert, buttonString: buttonString, showCancel: false) { }
            
            break
        case .player:
            self.setAnswer(tableView: tableView, cell: cell, indexPath: indexPath)
            break
        }
        
    }
    
    
}
