//
//  HomeConsumerVC.swift
//  Capture
//
//  Created by Hitesh Thummar on 28/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class HomePhotographerVC: UIViewController {
    
    @IBOutlet weak var lblMyLocation: UILabel!
    var locationManager:CLLocationManager!
    
    @IBOutlet weak var scrollReq: UIScrollView!
    
    var dataArr:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblMyLocation.text = "My location\n4225 Country Club Drive"        
        NOTIFICATIONCENTER.addObserver(self, selector: #selector(self.openProfilePhotographer), name: .openProfilePhotographer, object: nil)
        NOTIFICATIONCENTER.addObserver(self, selector: #selector(self.openSessionPhotographer), name: .openSessionPhotographer, object: nil)
        NOTIFICATIONCENTER.addObserver(self, selector: #selector(self.openNotificationPhotographer), name: .openNotificationPhotographer, object: nil)
        NOTIFICATIONCENTER.addObserver(self, selector: #selector(self.openBalancePhotographer), name: .openBalancePhotographer, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var y:CGFloat = 0
        for i in 0 ..< 10
        {
            let vw = Bundle.main.loadNibNamed("PhotographerRequestListView", owner: nil, options: nil)![0] as! PhotographerRequestListView
            vw.frame = CGRect(x: 0, y: y, width: SCREEN_SIZE.width - 36, height: 392)
            scrollReq.addSubview(vw)
            
           // vw.lblAddress.text = "Bundle.main.loadNibNamed Bundle.main.loadNibNamed Bundle.main.loadNibNamed Bundle.main.loadNibNamed"
            let height = vw.lblAddress.text!.height(withConstrainedWidth: SCREEN_SIZE.width - 91, font: UIFont(name: FONT_SF_DISPLAY_MEDIUM, size: 19)!)
            vw.CSAddressHeight.constant = height
            vw.layoutSubviews()
            vw.frame.size = CGSize(width: vw.frame.width, height: vw.mainView.frame.height)
            vw.btnAccept.addTarget(self, action: #selector(self.didTapOnAccept(_:)), for: .touchUpInside)
            vw.btnAccept.tag = i
            y = y + vw.mainView.frame.height + 20
        }
        scrollReq.contentSize = CGSize(width: SCREEN_SIZE.width - 36, height: y)
    }
    
    
    @IBAction func btnOpenMenu(_ sender: UIButton) {
        
        //openLeft()
    }
    
    @objc func didTapOnAccept(_ sender:UIButton)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RequestDetailFromRequestComeForPhotographer") as! RequestDetailFromRequestComeForPhotographer
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


//MARK:- Navigation

extension HomePhotographerVC
{
    @objc func openProfilePhotographer()
    {
      
    }
    
    @objc func openSessionPhotographer()
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SessionPhotographerVC") as! SessionPhotographerVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openNotificationPhotographer()
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotificationConsumerVC") as! NotificationConsumerVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openBalancePhotographer()
    {
       
    }
    
}



extension HomePhotographerVC : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen - Photo")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen - Photo")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose - Photo")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}
