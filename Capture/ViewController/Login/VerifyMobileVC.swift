//
//  LoginVC.swift
//  Capture
//
//  Created by Hitesh Thummar on 28/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class VerifyMobileVC: UIViewController {
    
    var isForChange = false;
    
    @IBOutlet weak var t1: UITextField!
    @IBOutlet weak var t2: UITextField!
    @IBOutlet weak var t3: UITextField!
    @IBOutlet weak var t4: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        t1.addBottomBorderWithColor(color: fromIntToColor(red: 151, green: 151, blue: 151, alpha: 1), width: 1)
        t2.addBottomBorderWithColor(color: fromIntToColor(red: 151, green: 151, blue: 151, alpha: 1), width: 1)
        t3.addBottomBorderWithColor(color: fromIntToColor(red: 151, green: 151, blue: 151, alpha: 1), width: 1)
        t4.addBottomBorderWithColor(color: fromIntToColor(red: 151, green: 151, blue: 151, alpha: 1), width: 1)
        
        
        t1.delegate = self
        t2.delegate = self
        t3.delegate = self
        t4.delegate = self
        t1.becomeFirstResponder()
        
    }

   
    @IBAction func btnsubmit(_ sender: Button) {
        
        if isForChange
        {
            self.pop(numberOfTimes: 2)
        }
        USERID = "0"
        btnCancel(sender)
        
        
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        
        if isForChange
        {
            self.navigationController?.popViewController(animated: true)
            return
        }
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension VerifyMobileVC:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        textField.text = ""
        if textField.text == "" {
            print("Backspace has been pressed")
        }
        
        if string == ""
        {
            print("Backspace was pressed")
            switch textField {
            case t2:
                t1.becomeFirstResponder()
            case t3:
                t2.becomeFirstResponder()
            case t4:
                t3.becomeFirstResponder()
            default:
                print("default")
            }
            textField.text = ""
            return false
        }
        return true
    }
    
    
    @IBAction func onEditingChange(_ sender: UITextField) {
        
        let count = sender.text?.count
        //
        if count == 1{
            
            switch sender {
            case t1:
                t2.becomeFirstResponder()
            case t2:
                t3.becomeFirstResponder()
            case t3:
                t4.becomeFirstResponder()
            case t4:
                t4.resignFirstResponder()
            default:
                print("default")
            }
        }
    }
    
    @IBAction func onEditingEnd(_ sender: UITextField) {
        
        
        if t1.text!.isStringEmpty() || t2.text!.isStringEmpty() || t3.text!.isStringEmpty() || t4.text!.isStringEmpty()
        {
            
        }
        else
        {
            print("done")
        }
        
    }
    
    
    
    
}
