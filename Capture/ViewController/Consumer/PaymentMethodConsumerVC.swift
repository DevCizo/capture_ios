//
//  SessionConsumerVC.swift
//  Capture
//
//  Created by Hitesh Thummar on 30/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit

class PaymentMethodConsumerVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var CSTableHeight: NSLayoutConstraint!
    
    var tableHeight:CGFloat = 55
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.reloadData()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tableview.rowHeight = UITableViewAutomaticDimension;
        
        CSTableHeight.constant = tableHeight * 2.0
        
    }
    
    
    @IBAction func btnAddNewCard(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddCardConsumerVC") as! AddCardConsumerVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}


extension PaymentMethodConsumerVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "PaymentMethodConsumerCell", for: indexPath) as! PaymentMethodConsumerCell
        
        if indexPath.row == 0
        {
            cell.lblCardType.text = "Mastercard"
            cell.lblCardLastfour.text = "5241"
        }
        
        if indexPath.row == 1
        {
            cell.lblCardType.text = "Visa"
            cell.lblCardLastfour.text = "4874"
        }
        

        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableHeight
    }
    
}



class PaymentMethodConsumerCell: UITableViewCell {
    
    @IBOutlet weak var lblCardType: UILabel!
    @IBOutlet weak var lblCardLastfour: UILabel!
    
    override func awakeFromNib() {
        if iPhone4 || iPhone5_SE
        {
            lblCardLastfour.setFontSize(size: 15)
            lblCardType.setFontSize(size: 15)
        }
    }
    
}
