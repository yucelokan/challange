//
//  AnswerTableViewCell.swift
//  Challange
//
//  Created by Okan Yücel on 26.11.2018.
//  Copyright © 2018 Okan Yücel. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var mViewBack: UIView!
    @IBOutlet weak var mLabelAnswer: UILabel!
    
    private var delegate: isEverythingOkayDelegate?
    public var isEverythingOkayDelegate: isEverythingOkayDelegate?{
        didSet{
            if let dlgt = isEverythingOkayDelegate{
                self.delegate = dlgt
            }
        }
    }
    
    public var answer: String?{
        didSet{
            if let item = answer{
                self.mLabelAnswer.text = item
            }else{
                delegate?.isEverythingOkay(isOkay: false)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.mViewBack.layer.borderWidth = 1
        self.mViewBack.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
