//
//  LoginVC.swift
//  sample-chat-swift
//
//  Created by Hitesh Thummar on 20/11/18.
//  Copyright © 2018 quickblox. All rights reserved.
//

import UIKit

class LoginChatVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//
//        let sp:QBUUser = QBUUser()
//        sp.login = "Hiii"
//        sp.password = "12345678"
//
//        QBRequest.signUp(sp, successBlock: { (res, user) in
//
//            print(sp)
//
//        }) { (res) in
//            if let err = res.value(forKey: "err")
//            {
//                print(err)
//            }
//        }
//
        

        let userC:QBUUser = QBUUser()
        userC.password = "12345678"
        userC.login = "hitesh"
        SVProgressHUD.show(withStatus: "SA_STR_LOGGING_IN_AS".localized + ("hitesh 11"), maskType: SVProgressHUDMaskType.clear)
        
        
        
        // Logging to Quickblox REST API and chat.
        ServicesManager.instance().logIn(with: userC, completion: {
            [weak self] (success,  errorMessage) -> Void in
            
            
//                        let chatDialog = QBChatDialog(dialogID: nil, type: QBChatDialogType.private)
//                        chatDialog.occupantIDs = [68056711]
//                        chatDialog.name = "hitesh"
//
//                        QBRequest.createDialog(chatDialog, successBlock: { (res, dia) in
//                            print(res)
//                        }, errorBlock: { (res) in
//                            print(res)
//                        })
            
            
            
            
            guard let strongSelf = self else {
                return
            }
            
            guard success else {
                SVProgressHUD.showError(withStatus: errorMessage)
                return
            }
            
            SVProgressHUD.showSuccess(withStatus: "SA_STR_LOGGED_IN".localized)
            strongSelf.performSegue(withIdentifier: "SA_STR_SEGUE_GO_TO_DIALOGS".localized, sender: nil)
            
        })
        

    }

    
}
