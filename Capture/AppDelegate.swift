//
//  AppDelegate.swift
//  Capture
//
//  Created by Hitesh Thummar on 28/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var shared = AppDelegate()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        AppDelegate.shared = self // set the value of "shared" to the current instance

        
//        for family in UIFont.familyNames {
//
//            let sName: String = family as String
//            print("family: \(sName)")
//
//            for name in UIFont.fontNames(forFamilyName: sName) {
//                print("name: \(name as String)")
//            }
//        }
        
        userLocation = CLLocationCoordinate2D(latitude: 42.688919, longitude: -72.052414);
        GMSServices.provideAPIKey(GOOGLE_MAP_KEY)
        GMSPlacesClient.provideAPIKey(GOOGLE_MAP_KEY)
        IQKeyboardManager.shared.enable = true
        
        
        QBSettings.applicationID = kQBApplicationID;
        QBSettings.authKey = kQBAuthKey
        QBSettings.authSecret = kQBAuthSecret
        QBSettings.accountKey = kQBAccountKey
        // enabling carbons for chat
        QBSettings.carbonsEnabled = true
        // Enables Quickblox REST API calls debug console output.
        QBSettings.logLevel = .debug
        
        // Enables detailed XMPP logging in console output.
        QBSettings.enableXMPPLogging()
        
//                let sp:QBUUser = QBUUser()
//                sp.login = "Nicjohn"
//                sp.password = "12345678"
//                sp.email = "nicjohn@gmail.com"
//                sp.fullName = "Nic john"
//                QBRequest.signUp(sp, successBlock: { (res, user) in
//                    print(sp)
//                }) { (res) in
//                    print("Sp Chat err.")
//                }
        
        // chat
        
        if ServicesManager.instance().currentUser.login == nil
        {
            let userC:QBUUser = QBUUser()
            userC.password = "12345678"
            //userC.login = "Nicjohn"
            userC.login = "john"
            checkForChatLogin()
            
            // Logging to Quickblox REST API and chat.
            ServicesManager.instance().logIn(with: userC, completion: {
                [weak self] (success,  errorMessage) -> Void in
            })
        }
        
     
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func setConsumerHomeAsRoot()
    {
        
        createMenuViewForConsumer()
        return
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        guard let rootViewController = window.rootViewController else {
            return
        }
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeConsumerVC")
        vc.view.frame = rootViewController.view.frame
        vc.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: {
            window.rootViewController = vc
        }, completion: { completed in
            // maybe do something here
            
            
        })
    }

    
    func logout()  {
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        guard let rootViewController = window.rootViewController else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectUserType")
        vc.view.frame = rootViewController.view.frame
        vc.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: {
            window.rootViewController = vc
        }, completion: { completed in
            // maybe do something here
            
        })
        
        USERID = ""        
        
    }
    
     func createMenuViewForConsumer() {
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "HomeConsumerVC") as! HomeConsumerVC
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "MenuConsumer") as! MenuConsumer
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        nvc.setNavigationBarHidden(true, animated: false)
       // UINavigationBar.appearance().tintColor = UIColor(hex: "689F38", alpha: 1)
        
        leftViewController.mainViewController = nvc
        
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: UIViewController())
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = mainViewController
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }
    
    
    func createMenuViewForPhotographer() {
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "HomePhotographerVC") as! HomePhotographerVC
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "MenuPhotographer") as! MenuPhotographer
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        nvc.setNavigationBarHidden(true, animated: false)
        // UINavigationBar.appearance().tintColor = UIColor(hex: "689F38", alpha: 1)
        
        leftViewController.mainViewController = nvc
        
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: UIViewController())
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = mainViewController
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }
    
    
    
    
    func checkForChatLogin() -> Bool
    {
        if ServicesManager.instance().currentUser.login == nil
        {
           // showToastMessage(msg: "Login in app");
            return false
        }
        return true
    }
    
    
    func loginInChat()
    {
        
    }    
    
}

