//
//  ViewController.swift
//  Capture
//
//  Created by Hitesh Thummar on 28/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit

class SelectUserType: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnConsumer(_ sender: Button) {
        AppDelegate.shared.setConsumerHomeAsRoot()
        
        
        
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func btnPhotographer(_ sender: Button) {
        
        AppDelegate.shared.createMenuViewForPhotographer()
        
        

    }
    
    

}

