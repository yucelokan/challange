//
//  FinalTableViewCell.swift
//  Challange
//
//  Created by Okan Yücel on 27.11.2018.
//  Copyright © 2018 Okan Yücel. All rights reserved.
//

import UIKit

class FinalTableViewCell: UITableViewCell {

    @IBOutlet weak var mLabelFirst: UILabel!
    
    public var textt: String?{
        didSet{
            if let item = textt{
                self.mLabelFirst.text = item
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
