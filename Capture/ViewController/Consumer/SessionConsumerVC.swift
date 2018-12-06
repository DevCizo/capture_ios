//
//  SessionConsumerVC.swift
//  Capture
//
//  Created by Hitesh Thummar on 30/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit

class SessionConsumerVC: UIViewController {

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
    
    @objc func btnOpenPhotos(_ sender:UIButton)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SessionPhotosConsumerVC") as! SessionPhotosConsumerVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func btnInviteFriend(_ sender:UIButton)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "InviteFriendConsumerVC") as! InviteFriendConsumerVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}


extension SessionConsumerVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "SessionConsumerCell", for: indexPath) as! SessionConsumerCell
        if indexPath.row == 0
        {
            cell.lblName.text = "Donnie\nAnderson"
            cell.lblTime.text = "9 Dec"
            cell.lblTime.text = "1:35"
            cell.lblMoney.text = "200$"
            cell.lblAddress.text = "1328 Montana Avenue"
            cell.lblExpectedTime.text = "Expected time: 21 December"
            cell.lblStatus.text = "Photos are prepared"
            cell.imgScroll.isHidden = true
            cell.expectedTimeView.isHidden = false
        }
        else
        {
            cell.lblName.text = "Monica\nFirs"
            cell.lblTime.text = "10 Dec"
            cell.lblTime.text = "1hr"
            cell.lblMoney.text = "2$"
            cell.lblAddress.text = "1328 Montana Avenue"
            cell.lblStatus.text = "Completed successfully"
            cell.expectedTimeView.isHidden = true
            cell.imgScroll.isHidden = false
            
            for vw in cell.imgScroll.subviews
            {
                vw.removeFromSuperview()
            }
            
            
            let totalWidth = SCREEN_SIZE.width - 82 - 32;
            let perImgWidth = totalWidth / 5
            
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
            
            cell.btn.tag = indexPath.row
            cell.btn.addTarget(self, action: #selector(self.btnOpenPhotos(_:)), for: .touchUpInside)
            
            cell.btnInviteFriend.tag = indexPath.row
            cell.btnInviteFriend.addTarget(self, action: #selector(self.btnInviteFriend(_:)), for: .touchUpInside)
            
            
            
        }
        
        
        for vw in cell.scrollUser.subviews
        {
            vw.removeFromSuperview()
        }
        
        var x = 0;
        for i in 0 ..< 3
        {
            
            let img  = UIImageView(frame: CGRect(x: x, y: 0, width: 34, height: 34))
            img.image = #imageLiteral(resourceName: "SamapleMan")
            cell.scrollUser.addSubview(img)
            img.setCornerRadious(radious: img.frame.width/2)
            img.setBorder(width: 4, color: UIColor.white)
            
            x = x + 20
        }
        
        
        return cell
    }
}



class SessionConsumerCell: UITableViewCell {
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMoney: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var expectedTimeView: UIView!
    @IBOutlet weak var lblExpectedTime: UILabel!
    @IBOutlet weak var btnInviteFriend: UIButton!
    @IBOutlet weak var scrollUser: UIScrollView!
    //41 + 83 + 97
    
    @IBOutlet weak var imgScroll: UIScrollView!
    //82
    @IBOutlet weak var btn: UIButton!
    
}
