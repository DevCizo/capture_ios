//
//  SessionConsumerVC.swift
//  Capture
//
//  Created by Hitesh Thummar on 30/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit

class NotificationConsumerVC: UIViewController {

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


extension NotificationConsumerVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "NotificationConsumerCell", for: indexPath) as! NotificationConsumerCell
        
        if indexPath.row == 0
        {
            cell.lblStatus.text = "Session changes status."
            cell.lblNotiText.text = "Andrew send photos"
            cell.lblDetails?.text = ""
            cell.CSDetailBottom.constant = 0
            cell.lblDate.text = "14 Dec        12:23PM"
        }
        if indexPath.row == 1
        {
            cell.lblStatus.text = "Session changes status."
            cell.lblNotiText.text = "Angela processed 10 photos"
            cell.lblDetails?.text = ""
            cell.CSDetailBottom.constant = 0
            cell.lblDate.text = "14 Dec        12:23PM"
        }
        if indexPath.row == 2
        {
            cell.lblStatus.text = "Promo."
            cell.lblNotiText.text = "Chrimas sale.\n-20% discount on all!"
            cell.lblDetails?.text = "Hurry up to please yourself with new professional photos."
            cell.CSDetailBottom.constant = 13
            cell.lblDate.text = "14 Dec        12:23PM"
        }
        
        
        return cell
    }
}



class NotificationConsumerCell: UITableViewCell {
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblNotiText: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var CSDetailBottom: NSLayoutConstraint!
    @IBOutlet weak var imgUser: UIImageView!
    
    
    
}
