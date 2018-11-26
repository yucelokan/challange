//
//  QuestionTableViewCell.swift
//  Challange
//
//  Created by Okan Yücel on 26.11.2018.
//  Copyright © 2018 Okan Yücel. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mLabelQuestionNum: UILabel!
    @IBOutlet weak var mLabelWildCardNum: UILabel!
    @IBOutlet weak var mLabelQuestionHeader: UILabel!
    @IBOutlet weak var mLabelQuestion: UILabel!
    @IBOutlet weak var mLabelAnswerHeader: UILabel!
    @IBOutlet weak var mViewBack: UIView!
    @IBOutlet weak var mLabelTime: UILabel!
    
    private var delegate: isEverythingOkayDelegate?
    public var isEverythingOkayDelegate: isEverythingOkayDelegate?{
        didSet{
            if let dlgt = isEverythingOkayDelegate{
                self.delegate = dlgt
            }
        }
    }
    public var userInformation : UserInformation?{
        didSet{
            if let item = userInformation{
                
                if let wildCardNum = item.wildCardCount{
                    mLabelWildCardNum.text = "Wild-Card\n\(wildCardNum)"
                }else{
                    self.delegate?.isEverythingOkay(isOkay: false)
                }
                
            }
        }
    }
    
    public var question: Question?{
        didSet{
            if let item = question{
                
                if let soruSira = item.soruSira, let toplamSoru = item.toplamSoru{
                    let soru = NSLocalizedString("id_soru", comment: "")
                    mLabelQuestionNum.text = soru + "\n\(soruSira) / \(toplamSoru)"
                }else{
                    mLabelQuestionNum.text = NSLocalizedString("id_hata", comment: "")
                    self.delegate?.isEverythingOkay(isOkay: false)
                }
                
                if let soru = item.soru{
                    mLabelQuestion.text = soru
                }else{
                    self.delegate?.isEverythingOkay(isOkay: false)
                }

            }
        }
    }
    
    func setSerializableStrings(){
        self.mLabelAnswerHeader.text = NSLocalizedString("id_cevaplar", comment: "")
        self.mLabelQuestionHeader.text = NSLocalizedString("id_soru", comment: "")
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setSerializableStrings()
        self.mViewBack.layer.borderWidth = 1
        self.mViewBack.layer.borderColor = UIColor.black.cgColor
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
