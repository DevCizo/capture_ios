//
//  SessionConsumerVC.swift
//  Capture
//
//  Created by Hitesh Thummar on 30/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit

class InviteFriendConsumerVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }

    @IBAction func btnBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
