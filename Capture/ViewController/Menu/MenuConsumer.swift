//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

enum LeftMenu: Int {
    case main = 0
    case swift
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class MenuConsumer : UIViewController, LeftMenuProtocol {
    
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
    
        NOTIFICATIONCENTER.post(name: .openSessionConsumer, object: nil)
        closeLeft()
        
       // self.slideMenuController()?.changeMainViewController(self.sessionConsumerVC, close: true)
    }
    
    @IBAction func btnNotification(_ sender: UIButton) {
        
        NOTIFICATIONCENTER.post(name: .openNotificationConsumer, object: nil)
        closeLeft()
        
        // self.slideMenuController()?.changeMainViewController(self.sessionConsumerVC, close: true)
    }
    @IBAction func btnInvite(_ sender: UIButton) {
        NOTIFICATIONCENTER.post(name: .openInviteConsumer, object: nil)
        closeLeft()
    }
    
    @IBAction func btnProfile(_ sender: UIButton) {
        NOTIFICATIONCENTER.post(name: .openProfileConsumer, object: nil)
        closeLeft()
    }
    
    @IBAction func btnPayment(_ sender: UIButton) {
        NOTIFICATIONCENTER.post(name: .openPaymentConsumer, object: nil)
        closeLeft()
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        slideMenuController()?.toggleLeft()
    }
    
    @IBAction func btnLogout(_ sender: UIButton) {
        
        ServicesManager.instance().logoutUserWithCompletion { [weak self] (boolValue) -> () in
            
            guard let strongSelf = self else { return }
            if boolValue {
                
                // ServicesManager.instance().chatService.removeDelegate(self)
                //  ServicesManager.instance().authService.remove(self)
                
                ServicesManager.instance().lastActivityDate = nil;
                
                
            }
        }
        
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





open class BaseTableViewCell : UITableViewCell {
    class var identifier: String { return String.className(self) }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    open override func awakeFromNib() {
    }
    
    open func setup() {
    }
    
    open class func height() -> CGFloat {
        return 48
    }
    
    open func setData(_ data: Any?) {
        self.backgroundColor = UIColor(hex: "F1F8E9", alpha: 1)
        self.textLabel?.font = UIFont.italicSystemFont(ofSize: 18)
        self.textLabel?.textColor = UIColor(hex: "9E9E9E", alpha: 1)
        if let menuText = data as? String {
            self.textLabel?.text = menuText
        }
    }
    
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.alpha = 0.4
        } else {
            self.alpha = 1.0
        }
    }
    
    // ignore the default handling
    override open func setSelected(_ selected: Bool, animated: Bool) {
    }
    
}

