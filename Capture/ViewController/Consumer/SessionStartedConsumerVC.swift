//
//  SessionConsumerVC.swift
//  Capture
//
//  Created by Hitesh Thummar on 30/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit

class SessionStartedConsumerVC: UIViewController {

    
    
    @IBOutlet weak var CSMainScrollHeight: NSLayoutConstraint!
    @IBOutlet weak var CSDetailViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if iPhone6_6s_7_8_Plus
        {
            CSDetailViewHeight.constant = 400
            CSMainScrollHeight.constant = 620
        }
      
        
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSessionEnd(_ sender: UIButton) {        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SessionEndedConsumerVC") as! SessionEndedConsumerVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func btnOpenchat(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DialogsViewController") as! DialogsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

