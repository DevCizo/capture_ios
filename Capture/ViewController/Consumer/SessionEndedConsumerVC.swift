//
//  SessionConsumerVC.swift
//  Capture
//
//  Created by Hitesh Thummar on 30/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit

class SessionEndedConsumerVC: UIViewController {

    
    @IBOutlet weak var scrollUserList: UIScrollView!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for vw in scrollUserList.subviews
        {
            vw.removeFromSuperview()
        }
        
        var x = 0;
        for i in 0 ..< 3
        {
            let img  = UIImageView(frame: CGRect(x: x, y: 0, width: 42, height: 42))
            img.image = #imageLiteral(resourceName: "SamapleMan")
            scrollUserList.addSubview(img)
            img.setCornerRadious(radious: img.frame.width/2)
            img.setBorder(width: 4, color: fromIntToColor(red: 233, green: 236, blue: 247, alpha: 1))
            
            x = x + 25
        }
        
    }
    
    @IBAction func btnDone(_ sender: Button) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}

