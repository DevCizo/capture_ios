//
//  ShareCodeInfoView.swift
//  Capture
//
//  Created by Hitesh Thummar on 29/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit

class ShareCodeInfoView: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var CSTitleLblHeight: NSLayoutConstraint!
    @IBOutlet weak var infoView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if iPhoneXS_MAX || iPhoneXR || iPhoneX_XS || iPhone6_6s_7_8_Plus
        {
            lblTitle.setFontSize(size: 32)
            CSTitleLblHeight.constant = 85
        }
        
        if iPhone4 || iPhone5_SE
        {
            lblTitle.setFontSize(size: 26)
            CSTitleLblHeight.constant = 70
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.infoView.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.infoView.alpha = 1
        }) { (bool) in
        }
    }
    
    
    @IBAction func btnGo(_ sender: Button) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.infoView.alpha = 0
            //self.view.alpha = 0
        }) { (bool) in
            self.dismiss(animated: false, completion: nil)
        }
        
        
    }
    

}
