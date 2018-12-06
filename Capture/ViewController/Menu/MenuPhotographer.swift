//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit




class MenuPhotographer : UIViewController, LeftMenuProtocol {
    
    var menus = ["Main", "Swift"]
    
    var mainViewController: UIViewController!
    var sessionConsumerVC: UIViewController!
    
    
    @IBOutlet weak var CSContentHeight: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       // let storyboard = UIStoryboard(name: "Home", bundle: nil)
        //let sessionVC = storyboard.instantiateViewController(withIdentifier: "SessionConsumerVC") as! SessionConsumerVC
        //self.sessionConsumerVC = UINavigationController(rootViewController: sessionVC)
      
        if iPhoneX_XS
        {
            CSContentHeight.constant = 640
        }
        
        if iPhoneXR
        {
            CSContentHeight.constant = 750
        }
        
        if iPhoneXS_MAX
        {
            CSContentHeight.constant = 750
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .swift:
            self.slideMenuController()?.changeMainViewController(self.sessionConsumerVC, close: true)
        }
    }
    
    
    @IBAction func btnSession(_ sender: UIButton) {
    
        NOTIFICATIONCENTER.post(name: .openSessionPhotographer, object: nil)
        closeLeft()
        
       // self.slideMenuController()?.changeMainViewController(self.sessionConsumerVC, close: true)
    }
    
    @IBAction func btnNotification(_ sender: UIButton) {
        
        NOTIFICATIONCENTER.post(name: .openNotificationPhotographer, object: nil)
        closeLeft()
        
        // self.slideMenuController()?.changeMainViewController(self.sessionConsumerVC, close: true)
    }
 
    
    @IBAction func btnProfile(_ sender: UIButton) {
        NOTIFICATIONCENTER.post(name: .openProfilePhotographer, object: nil)
        closeLeft()
    }
    
    @IBAction func btnPayment(_ sender: UIButton) {
        NOTIFICATIONCENTER.post(name: .openBalancePhotographer, object: nil)
        closeLeft()
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        slideMenuController()?.toggleLeft()
    }
    
    @IBAction func btnLogout(_ sender: UIButton) {
        
        AppDelegate.shared.logout()
        
    }
}

//extension MenuConsumer : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if let menu = LeftMenu(rawValue: indexPath.row) {
//            switch menu {
//            case .main, .swift:
//                return BaseTableViewCell.height()
//            }
//        }
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let menu = LeftMenu(rawValue: indexPath.row) {
//            self.changeViewController(menu)
//        }
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if self.tableView == scrollView {
//
//        }
//    }
//}


