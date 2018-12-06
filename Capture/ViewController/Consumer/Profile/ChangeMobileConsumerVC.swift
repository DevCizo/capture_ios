//
//  SessionConsumerVC.swift
//  Capture
//
//  Created by Hitesh Thummar on 30/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit

class ChangeMobileConsumerVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


    }

    @IBAction func btnBack(_ sender: UIButton) {
        
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func btnNext(_ sender: Button) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "VerifyMobileVC") as! VerifyMobileVC
        vc.isForChange = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

