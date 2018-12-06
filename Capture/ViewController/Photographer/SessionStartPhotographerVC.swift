//
//  HomeConsumerVC.swift
//  Capture
//
//  Created by Hitesh Thummar on 28/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit


class SessionStartPhotographerVC: UIViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    @IBAction func btnOpenchat(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DialogsViewController") as! DialogsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnFinishSession(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SessionEndedPhotographerVC") as! SessionEndedPhotographerVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnOpenMenu(_ sender: UIButton) {

        navigationController?.popViewController(animated: true)
    }
    
    
}
