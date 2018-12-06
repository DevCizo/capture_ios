//
//  SessionConsumerVC.swift
//  Capture
//
//  Created by Hitesh Thummar on 30/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit

class SessionPhotographerVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.reloadData()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tableview.rowHeight = UITableViewAutomaticDimension;


    }

    @IBAction func btnBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }    
}


extension SessionPhotographerVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "SessionPhotographerCell", for: indexPath) as! SessionPhotographerCell
        
        
        cell.CSScrollTop.constant = 30
        cell.CSScrollHeight.constant = 46
        cell.CSUploadBtnTop.constant = 5
        cell.CSUploadMoreBtnHeight.constant = 48
        
        cell.imgScroll.isHidden = false
        
        
        
        if indexPath.row == 0
        {
            cell.lblName.text = "Harold\nCopeland"
            cell.lblTime.text = "9 Dec"
            cell.lblTime.text = "1:35"
            cell.lblMoney.text = "200$"
            cell.lblAddress.text = "1328 Montana Avenue"
            cell.lblStatus.text = "Incomplete"
            cell.imgScroll.isHidden = true
            cell.btnUpload.setTitle("Upload Photos", for: .normal)
            
            cell.CSScrollHeight.constant = 0
            cell.CSScrollTop.constant = 0
            cell.CSUploadMoreBtnHeight.constant = 0
            cell.CSUploadBtnTop.constant = 0
            
        }
        else
        {
            cell.lblName.text = "Jorge\nVolter"
            cell.lblTime.text = "10 Dec"
            cell.lblTime.text = "1hr"
            cell.lblMoney.text = "2$"
            cell.lblAddress.text = "1328 Montana Avenue"
            cell.lblStatus.text = "Incomplete"
            cell.imgScroll.isHidden = false
            cell.btnUpload.setTitle("Complete order", for: .normal)
            
            cell.CSScrollTop.constant = 30
            cell.CSScrollHeight.constant = 46
            cell.CSUploadBtnTop.constant = 5
            cell.CSUploadMoreBtnHeight.constant = 48
            
            
            for vw in cell.imgScroll.subviews
            {
                vw.removeFromSuperview()
            }
            
            
            let totalWidth = SCREEN_SIZE.width - 82 - 32;
            var perImgWidth = totalWidth / 5
            
            if perImgWidth > 46
            {
                perImgWidth = 46
            }
            
            var x:CGFloat = 0;
            for i in 0 ..< 5
            {
                let img  = UIImageView(frame: CGRect(x: x, y: 0, width: perImgWidth, height: perImgWidth))
                img.image = #imageLiteral(resourceName: "sessionPicImg")
                img.contentMode = .center
                img.backgroundColor = UIColor(hex: "E9ECF6", alpha: 1)
                cell.imgScroll.addSubview(img)
                img.setCornerRadious(radious: 5)
                x = x + perImgWidth + 8
                
                if i == 4
                {
                    img.image = nil
                    
                    let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: img.frame.width, height: img.frame.height))
                    lbl.text = "+35"
                    lbl.textAlignment = .center
                    lbl.textColor = fromIntToColor(red: 28, green: 28, blue: 28, alpha: 1)
                    lbl.font = UIFont(name: FONT_SF_DISPLAY_REGULAR, size: 14)
                    img.addSubview(lbl)
                }
            }
            
        }
        return cell
    }
}



class SessionPhotographerCell: UITableViewCell {
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMoney: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnUpload: Button!
    //41 + 83 + 97
    
    @IBOutlet weak var imgScroll: UIScrollView!
    //82
    
    @IBOutlet weak var CSScrollHeight: NSLayoutConstraint!
    @IBOutlet weak var CSScrollTop: NSLayoutConstraint!
    @IBOutlet weak var CSUploadMoreBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var CSUploadBtnTop: NSLayoutConstraint!
    
    
    
    
}
