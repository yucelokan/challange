//
//  FinalViewController.swift
//  Challange
//
//  Created by Okan Yücel on 26.11.2018.
//  Copyright © 2018 Okan Yücel. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
    
    init() {
        super.init(nibName: "FinalViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var mLabelSecond: UILabel!
    @IBOutlet weak var mLabelFirst: UILabel!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mButtonDismiss: UIButton!
    
    var mFinalResults:Results?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mTableView.register(FinalTableViewCell.classForCoder(), forCellReuseIdentifier: "FinalTableViewCell")
        self.mTableView.register(UINib.init(nibName: "FinalTableViewCell", bundle: nil), forCellReuseIdentifier: "FinalTableViewCell")

        self.setLocalizableStrings()
        
        self.loadFinalResults()
        // Do any additional setup after loading the view.
    }
    
    func loadFinalResults(){
        RequestManager.instance.getResults { (status, result) in
            if status{
                
                let text = NSLocalizedString("id_earnedMoney", comment: "")
                
                self.mLabelFirst.text = "\(text)\n\n\(result.kazanilanPara ?? "0")"
                self.mFinalResults = result
                self.mTableView.reloadData()
            }
        }
    }
    
    func setLocalizableStrings(){
        self.mLabelSecond.text = NSLocalizedString("id_correctAllUsers", comment: "")
        self.mLabelFirst.text = NSLocalizedString("id_earnedMoney", comment: "")
        self.mButtonDismiss.setTitle(NSLocalizedString("id_tamam", comment: ""), for: .normal)
    }
    
    @IBAction func dismissButtonTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension FinalViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mFinalResults?.kazananlar?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let selectedItem = self.mFinalResults?.kazananlar?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FinalTableViewCell", for: indexPath) as? FinalTableViewCell
        
        cell?.textt = selectedItem
        
        return cell ?? UITableViewCell.init(frame: CGRect.zero)
    }
    
    
}
