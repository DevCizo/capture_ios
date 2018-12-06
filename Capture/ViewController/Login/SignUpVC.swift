//
//  LoginVC.swift
//  Capture
//
//  Created by Hitesh Thummar on 28/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class SignUpVC: UIViewController {

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtNumber: SkyFloatingLabelTextField!
    @IBOutlet weak var txtName: SkyFloatingLabelTextField!
    @IBOutlet weak var lblHeading: UILabel!
    
    
    @IBOutlet weak var CSTxtNameHeight: NSLayoutConstraint!
    @IBOutlet weak var CSTxtMobileTop: NSLayoutConstraint!
    
    
    @IBOutlet weak var btnContinue: Button!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnContinue.setFontSize(size: 16)
        txtNumber.setRightPaddingPoints(80)
        
        if !isConsumerInSignUpLogin
        {
            lblHeading.text = "Sign up to become a photographer partner"
            CSTxtNameHeight.constant = 0
            CSTxtMobileTop.constant = 0
            lblName.isHidden = true
            txtName.isHidden = true
        }
        
        
    }
    
   

    @IBAction func btncontinue(_ sender: Button) {
        
        if isConsumerInSignUpLogin
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "VerifyMobileVC") as! VerifyMobileVC
            //self.present(vc, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileInfoAddPhotographerVC") as! ProfileInfoAddPhotographerVC
            //self.present(vc, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
        
        
    }
    
    
    @IBAction func btnCancel(_ sender: UIButton) {
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
        //self.present(vc, animated: true, completion: nil)
    }

}
