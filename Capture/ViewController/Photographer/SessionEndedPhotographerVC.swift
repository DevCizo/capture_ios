//
//  SessionConsumerVC.swift
//  Capture
//
//  Created by Hitesh Thummar on 30/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit

class SessionEndedPhotographerVC: UIViewController {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnDone(_ sender: Button) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}

