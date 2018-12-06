//
//  LoginVC.swift
//  Capture
//
//  Created by Hitesh Thummar on 28/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class LoginVC: UIViewController {

    
    @IBOutlet weak var txtNumber: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var btnInsta: Button!
    @IBOutlet weak var btnGo: Button!
    @IBOutlet weak var btnFB: Button!
    @IBOutlet weak var btnContinue: Button!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        btnContinue.setFontSize(size: 16)
        btnFB.setFontSize(size: 16)
        btnGo.setFontSize(size: 16)
        btnInsta.setFontSize(size: 16)
        
        txtNumber.setRightPaddingPoints(90)
        
        
    }

    @IBAction func btncontinue(_ sender: UIButton) {
        USERID = "1"
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
