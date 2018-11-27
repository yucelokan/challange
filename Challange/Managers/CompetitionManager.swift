//
//  CompetitionManager.swift
//  Challange
//
//  Created by Okan Yücel on 27.11.2018.
//  Copyright © 2018 Okan Yücel. All rights reserved.
//

import UIKit

private var competitionManager: CompetitionManager?

public enum answerType{
    case truee, falsee, waiting, defaultt
}

class CompetitionManager: NSObject {
    
    class var instance: CompetitionManager {
        
        if competitionManager == nil {
            competitionManager = CompetitionManager()
        }
        
        return competitionManager!
    }
    
    
    func setAnswerBackground(type : answerType ,cell: AnswerTableViewCell){
        
        // cevaba tıkladığında ve yeni cevap geldiğinde çalışır
        
        switch type {
        case .defaultt:
            // yeni soru geldiğinde beyaz arkaplan olur aşağıda setAll fonksiyon var
            cell.mViewBack.backgroundColor = UIColor.white
            cell.mLabelAnswer.textColor = UIColor.black
            break
        case .waiting:
            //cevaba tıkladığında arka planı turuncu yapar
            cell.mViewBack.backgroundColor = UIColor.init(hexString: "ffc04c")!
            cell.mLabelAnswer.textColor = UIColor.black
            break
        case .falsee:
            // yanlışsa kırmızı
            cell.mViewBack.backgroundColor = UIColor.init(hexString: "ff3232")!
            cell.mLabelAnswer.textColor = UIColor.white
            break
        case .truee:
            //doğruysa yeşil
            cell.mViewBack.backgroundColor = UIColor.init(hexString: "4CB74C")!
            cell.mLabelAnswer.textColor = UIColor.black
            break
        }
        
    }
    
    func checkAnswer(selectedAnswer: String?, correctAnswer: String?, tableView: UITableView) -> Bool{
        
        var answer = false
        
        //soruya verilen cevap doğru mu yanlış mı kontrol edilir
        
        // doğruya yeşil olur
        //yanlışsa kırmızı olur doğru cevap yeşil olur.
        
        for i in 0...tableView.numberOfRows(inSection: 0){
            if let cell = tableView.cellForRow(at: IndexPath.init(row: i + 1, section: 0)) as? AnswerTableViewCell{
                guard let cellText = cell.mLabelAnswer.text else{
                    return false
                }
                
                self.setAnswerBackground(type: .defaultt, cell: cell)
                
                if selectedAnswer == correctAnswer && cellText == correctAnswer {
                    self.setAnswerBackground(type: .truee, cell: cell)
                    answer = true
                    if let topVC = HelperManager.topViewController() {
                        let message = NSLocalizedString("id_dogru", comment: "")
                        AlertManager.instance.showPositiveMessage(message: message, time: 2, controller: topVC)
                    }
                }else if selectedAnswer != correctAnswer && cellText == selectedAnswer {
                    self.setAnswerBackground(type: .falsee, cell: cell)
                    answer = false
                    if let topVC = HelperManager.topViewController() {
                        let message = NSLocalizedString("id_yanlis", comment: "")
                        AlertManager.instance.showNegativeMessage(message: message, time: 2, controller: topVC)
                    }
                }else if cellText == correctAnswer{
                    self.setAnswerBackground(type: .truee, cell: cell)
                     answer = false
                }
                
       
            }
        }
        
        return answer
    }
    
    func askUserWildCard(){
        
    }
    
    func setAllDefaultBackground(tableView: UITableView){
        for i in 0...tableView.numberOfRows(inSection: 0){
            if let cell = tableView.cellForRow(at: IndexPath.init(row: i + 1, section: 0)) as? AnswerTableViewCell{
                self.setAnswerBackground(type: .defaultt, cell: cell)
            }
        }
    }
    
    

}
