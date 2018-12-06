//
//  CustomClass.swift
//  Capture
//
//  Created by Hitesh Thummar on 28/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
        
        self.titleLabel?.font = UIFont(name: FONT_SF_DISPLAY_REGULAR, size: 18);
        
        if self.frame.height == 38
        {
                self.titleLabel?.font = UIFont(name: FONT_SF_DISPLAY_REGULAR, size: 16);
        }
        
        
        if iPhone4 || iPhone5_SE
        {
                self.titleLabel?.font = UIFont(name: FONT_SF_DISPLAY_REGULAR, size: 18);
        }
        
    }
    
}
