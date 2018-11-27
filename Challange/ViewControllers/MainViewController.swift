//
//  MainViewController.swift
//  Challange
//
//  Created by Okan Yücel on 26.11.2018.
//  Copyright © 2018 Okan Yücel. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mLabelFirst: UILabel!
    
    var userInformation: UserInformation?
    var counter = 5
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLocalizableStrings()
        
       self.getUserInformation()
        
    }
    
    func getUserInformation(){
        RequestManager.instance.getUserInformations { (status, result) in
            if status{
                self.userInformation = result
                self.setLocalizableStrings()
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startCountDown), userInfo: nil, repeats: true)
                }
            }else{
                self.mLabelFirst.text = NSLocalizedString("id_tiklaTekrarDene", comment: "")
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tryAgain))
                self.mLabelFirst.isUserInteractionEnabled = true
                self.mLabelFirst.addGestureRecognizer(tap)
            }
        }
    }
    
    func getFirstQuestion(){
        RequestManager.instance.getQuestion(questionNumber: 1) { (status, result) in
            if status{
                self.mLabelFirst.isUserInteractionEnabled = false
                self.mLabelFirst.text = NSLocalizedString("id_yarismaBasladi", comment: "")
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tryAgain))
                self.mLabelFirst.isUserInteractionEnabled = true
                self.mLabelFirst.addGestureRecognizer(tap)
                self.startCompetition(question: result)
            }else{
                 self.mLabelFirst.text = NSLocalizedString("id_tiklaTekrarDene", comment: "")
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tryAgain))
                self.mLabelFirst.isUserInteractionEnabled = true
                self.mLabelFirst.addGestureRecognizer(tap)
            }
        }

    }
  
    func startCompetition(question: Question){
        guard let userInfo = self.userInformation else{
            return
        }
        let questionVC = QuestionViewController.init(question: question, userInfo: userInfo)
        present(questionVC, animated: false, completion: nil)
    }
    
    @objc func startCountDown(){
        
        guard let name = self.userInformation?.name else{
            return
        }
        
        guard let wildCardCount = self.userInformation?.wildCardCount else{
            return
        }
        
        let hello = NSLocalizedString("id_merhaba", comment: "")
        let text = "\(hello), \(name),\n Wild-Card : \(wildCardCount)\n\n\(self.counter)"
        
        self.mLabelFirst.text = text
        self.counter -= 1
        
        if counter == -1{
            self.counter = 5
            self.timer.invalidate()
            self.getFirstQuestion()
        }
        
    }
    
    @objc func tryAgain(){
        guard let _ = self.userInformation else{
            self.getUserInformation()
            return
        }
        
        self.getFirstQuestion()
        
    }
    
    
    func setLocalizableStrings(){
        
        guard let name = self.userInformation?.name else{
            return
        }
        
        guard let wildCardCount = self.userInformation?.wildCardCount else{
            return
        }
        
        let hello = NSLocalizedString("id_merhaba", comment: "")
        let info  = NSLocalizedString("id_yarismaBaslamakUzere", comment: "")
        let text = "\(hello), \(name),\n Wild-Card : \(wildCardCount)\n\n\(info)"
        
        self.mLabelFirst.text = text
    }

}
