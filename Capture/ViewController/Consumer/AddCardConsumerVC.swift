//
//  SessionConsumerVC.swift
//  Capture
//
//  Created by Hitesh Thummar on 30/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit
import CCValidator
import SkyFloatingLabelTextField

class AddCardConsumerVC: UIViewController {
   
    @IBOutlet weak var txtCardNumber: VSTextField!
    @IBOutlet weak var txtValidity: VSTextField!
    @IBOutlet weak var txtCvv: VSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        txtCardNumber.setRightPaddingPoints(50)
        
        
        txtCardNumber.setFormatting("#### #### #### ####", replacementChar: "#")
        txtValidity.setFormatting("##/####", replacementChar: "#")
        txtCvv.setFormatting("###", replacementChar: "#")
    }

    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnAddCard(_ sender: Button) {
        self.btnBack(sender)
    }
    
}


extension AddCardConsumerVC
{
    
    
    @IBAction func cardNumberEditing(_ sender: UITextField) {
        
        let recognizedType = CCValidator.typeCheckingPrefixOnly(creditCardNumber: sender.text!)
        print(recognizedType.rawValue)
        
        
        switch recognizedType.rawValue {
        case 0:
            txtCardNumber.setFormatting("#### ###### #####", replacementChar: "#")
            break;
        case 6,9,3,4,5:
            txtCardNumber.setFormatting("#### #### #####", replacementChar: "#")
            break;
        default:
            
            break
        }
    }
    
    @IBAction func txtValidityAndCvvEditing(_ sender: UITextField) {
        
        if sender == txtValidity
        {
            if sender.text!.count == 6
            {
                txtCvv.becomeFirstResponder()
            }
        }
        
        if sender == txtCvv
        {
            
        }
        
    }
    
}

//
//enum CreditCardType: Int {
//    case AmericanExpress
//    case Dankort
//    case DinersClub
//    case Discover
//    case JCB
//    case Maestro
//    case MasterCard
//    case UnionPay
//    case VisaElectron
//    case Visa
//    case NotRecognized
//}
