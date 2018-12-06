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

class HomeConsumerVC: UIViewController {
    
    @IBOutlet weak var mapContainerView: UIView!
    var locationManager:CLLocationManager!

    
    @IBOutlet weak var btnBrush: UIButton!
    @IBOutlet weak var btnInvite: UIButton!
    
    var mapView:GMSMapView!
    var userLocationMarker: GMSMarker!

    
    @IBOutlet weak var capturingView: UIView!
    @IBOutlet weak var captureView: UIView!
    @IBOutlet weak var photographerFoundView: UIView!
    
    //MARK:- Go Through
    
    
    @IBOutlet weak var lblVerticalLinrToRotate: UILabel!
    
    
    @IBOutlet weak var btnSignUpGo1: Button!
    @IBOutlet weak var btnNextGo1: Button!
    @IBOutlet weak var lblGO1Desc: UILabel!
    @IBOutlet weak var lblGo12: UILabel!
    @IBOutlet weak var lblGo1SignUp: UILabel!
    
    
    @IBOutlet weak var btnDoneGo2: Button!
    @IBOutlet weak var lblGO2Desc: UILabel!
    @IBOutlet weak var lblGo222: UILabel!
    
    @IBOutlet weak var CSLblLineLeft: NSLayoutConstraint!
    @IBOutlet weak var CSGo2DescWidth: NSLayoutConstraint!
    
    
    //MARK:- Capturing view
    
    @IBOutlet weak var btnCancelCapturing: Button!
    
    @IBOutlet weak var goThroughBG: UIView!
    @IBOutlet weak var goThroughViewMain: UIView!
    @IBOutlet weak var goThrough1: UIView!
    @IBOutlet weak var goThrough2: UIView!
    
    //MARK:- Photographer Found
    
    
    @IBOutlet weak var btnOpenStartSessionScreen: UIButton!
    
    
    
    
    @IBOutlet weak var CSGo1AreUPhotographerWidth: NSLayoutConstraint!
    @IBOutlet weak var CSgoThrough1DotLeft: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        NOTIFICATIONCENTER.addObserver(self, selector: #selector(self.openSessionConsumer), name: .openSessionConsumer, object: nil)
        NOTIFICATIONCENTER.addObserver(self, selector: #selector(self.openNotificationConsumer), name: .openNotificationConsumer, object: nil)
        NOTIFICATIONCENTER.addObserver(self, selector: #selector(self.openInviteConsumer), name: .openInviteConsumer, object: nil)
        NOTIFICATIONCENTER.addObserver(self, selector: #selector(self.openProfileConsumer), name: .openProfileConsumer, object: nil)
        NOTIFICATIONCENTER.addObserver(self, selector: #selector(self.openPaymentMethodConsumer), name: .openPaymentConsumer, object: nil)
        
        
        locationManager = CLLocationManager()
        
        addMap()
        self.perform(#selector(self.initLocationService), with: nil, afterDelay: 0.01)
        
        CSgoThrough1DotLeft.constant = 37
        
        hideAllGoThrough()
        showGoThroughFromStart()
       
        btnCancelCapturing.cornerRadius = 0
        btnCancelCapturing.roundCorners(corners: [.topRight,.bottomRight], radius: 24)
        setBottomViewForFirst()        
        
        lblVerticalLinrToRotate.transform = CGAffineTransform(rotationAngle: 60)
        btnInvite.isHidden = true
        btnOpenStartSessionScreen.isHidden = true
        
        
        if iPhone4 || iPhone5_SE
        {
            btnSignUpGo1.titleLabel?.setFontSize(size: 14)
            btnNextGo1.titleLabel?.setFontSize(size: 14)
            lblGO1Desc.setFontSize(size: 15)
            lblGo12.setFontSize(size: 15)
            lblGo1SignUp.setFontSize(size: 15)
            CSLblLineLeft.constant = 10
            CSGo1AreUPhotographerWidth.constant = 96
            
            btnSignUpGo1.setTitle("         SIGN UP          ", for: .normal)
             btnNextGo1.setTitle("         NEXT          ", for: .normal)
            
            
            btnDoneGo2.titleLabel?.setFontSize(size: 14)
            lblGO2Desc.setFontSize(size: 15)
            lblGo222.setFontSize(size: 15)
            CSGo2DescWidth.constant = 140
            btnDoneGo2.setTitle("         DONE         ", for: .normal)
        }
        
    }
    
    
    @IBAction func btnOpenMenu(_ sender: UIButton) {
        if USERID == ""
        {
            let stbd = UIStoryboard(name: "Main", bundle: nil)
            let vc = stbd.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
            //self.present(vc, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        openLeft()
    }
    
    func addMap() {
        
        let camera = GMSCameraPosition.camera(withLatitude: 38.909772, longitude: -86.508327, zoom: 10.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapContainerView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isMyLocationEnabled = true
        
        addUserCurrentLocationMarker()
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "mapStyle", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        
        
        let topConstraint = mapView.topAnchor.constraint(equalTo: mapContainerView.topAnchor)
        let leftConstraint = mapView.leftAnchor.constraint(equalTo: mapContainerView.leftAnchor)
        let bottomConstraint = mapView.bottomAnchor.constraint(equalTo: mapContainerView.bottomAnchor)
        let rightConstraint = mapView.rightAnchor.constraint(equalTo: mapContainerView.rightAnchor)
        view.addConstraints([topConstraint,leftConstraint,bottomConstraint,rightConstraint])
    }
    
    func clearMap()
    {
        self.mapView.clear()
    }
    func addUserCurrentLocationMarker()
    {
        if userLocationMarker == nil
        {
            userLocationMarker = GMSMarker()
        }
        userLocationMarker.position = CLLocationCoordinate2D(latitude: 38.909772, longitude: -86.508327)
        userLocationMarker.map = self.mapView
        userLocationMarker.icon = (iPhone4 || iPhone5_SE) ? #imageLiteral(resourceName: "userCurrentLocationsmall"): #imageLiteral(resourceName: "userCurrentLocation")
    }
    
    
    @IBAction func btnSearch(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchPlaceConsumerVC") as! SearchPlaceConsumerVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnBrush(_ sender: UIButton) {
        if USERID == ""
        {
            let stbd = UIStoryboard(name: "Main", bundle: nil)
            let vc = stbd.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
            //self.present(vc, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UploadPhotoForEditConsumerVC") as! UploadPhotoForEditConsumerVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnOpenSessionStartScreem(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SessionStartedConsumerVC") as! SessionStartedConsumerVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    //MARK:- capture
    
    func setBottomViewForFirst()
    {
        captureView.isHidden = false
        capturingView.isHidden = true
        photographerFoundView.isHidden = true
    }
    
    @IBAction func btnCapture(_ sender: Button) {
        
        if USERID == ""
        {
            let stbd = UIStoryboard(name: "Main", bundle: nil)
            let vc = stbd.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
            //self.present(vc, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        
        captureView.isHidden = true
        capturingView.isHidden = false
    }
    
    
     //MARK:- capturing
    
    
    @IBAction func btnCapturingCancel(_ sender: Button) {
        
        captureView.isHidden = false
        capturingView.isHidden = true
        btnOpenStartSessionScreen.isHidden = true
    }
    
    
    @IBAction func onBtnCapturing(_ sender: UIButton) {
        
        btnOpenStartSessionScreen.isHidden = false
        photographerFoundView.isHidden = false
        capturingView.isHidden = true
        
        btnBrush.isHidden = true
        btnInvite.isHidden = false
        
        APICall.getRouteForGoogleMap(source: CLLocationCoordinate2D(latitude: 38.909772, longitude: -86.508327), destination: CLLocationCoordinate2D(latitude: 37.414618, longitude: -79.437344)) {[weak self] (route) in
            
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.drawPathOnMap(pathStr: route, map: strongSelf.mapView)
        }
        
    }
    
    func drawPathOnMap(pathStr:String,map:GMSMapView)
    {
        let path = GMSPath(fromEncodedPath: pathStr)
        let rectangle = GMSPolyline(path: path)
        rectangle.map = nil;
        rectangle.strokeWidth = 3
        rectangle.strokeColor = UIColor.black
        rectangle.map = map
        
        if let togmspath = GMSPath(fromEncodedPath: pathStr)
        {
            self.mapFitView(path: togmspath, map: map, padding: UIEdgeInsetsMake(40, 40, 40, 40))
        }
        
        // add marker
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 37.414618, longitude: -79.437344)
        marker.icon = #imageLiteral(resourceName: "mapMarker")
        marker.map = mapView
    }
    
    func mapFitView(path:GMSPath,map:GMSMapView,padding:UIEdgeInsets)
    {
        var bounds = GMSCoordinateBounds()
        for index in 1...path.count()
        {
            bounds = bounds.includingCoordinate(path.coordinate(at: UInt(index)))
        }
        map.animate(with: GMSCameraUpdate.fit(bounds, with: padding))
    }
    
    
    //MARK:- photoGrapher Found
    
    
    @IBAction func btnPhotoGrapherFoundCancel(_ sender: UIButton) {
        
        photographerFoundView.isHidden = true
        captureView.isHidden = false
        btnBrush.isHidden = false
        btnInvite.isHidden = true
        btnOpenStartSessionScreen.isHidden = true
        clearMap()
        self.addUserCurrentLocationMarker()
        
    }
    
    @IBAction func btnOpenchatForPhotographer(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DialogsViewController") as! DialogsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @objc func openSessionConsumer()
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SessionConsumerVC") as! SessionConsumerVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openNotificationConsumer()
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotificationConsumerVC") as! NotificationConsumerVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openInviteConsumer()
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "InviteFriendConsumerVC") as! InviteFriendConsumerVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    @objc func openProfileConsumer()
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileConsumerVC") as! ProfileConsumerVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openPaymentMethodConsumer()
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PaymentMethodConsumerVC") as! PaymentMethodConsumerVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension HomeConsumerVC: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
//        userLocation = location.coordinate;
//        locationManager.stopUpdatingLocation()
//        locationManager.stopMonitoringSignificantLocationChanges()
//
//
//        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
//                                              longitude: location.coordinate.longitude,
//                                              zoom: 14.0)
//        mapView.camera = camera
//        mapView.animate(to: camera)
        
        //37.414618
        //-79.437344
        
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    
    @objc func initLocationService() {
        
        let status  = CLLocationManager.authorizationStatus()
        
        // 3
        if status == .denied || status == .restricted {
           
        }
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
}


//MARK:- Go Through functions

extension HomeConsumerVC
{
    @IBAction func btn1GoThrough(_ sender: Button) {
        
        goThrough2.isHidden = false
        goThrough1.isHidden = true
        
    }
    
    @IBAction func btn1GoThroughSignUpPhotoGrapher(_ sender: Button) {
        
        isConsumerInSignUpLogin = false
        
        //AppDelegate.shared.createMenuViewForPhotographer()
        return
        
        
        
        let stbd = UIStoryboard(name: "Main", bundle: nil)
        let vc = stbd.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        //self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func btnShow1GoThrough(_ sender: UIButton) {
        goThrough2.isHidden = true
        goThrough1.isHidden = false
    }
    
    @IBAction func btnHideAllGoThrough(_ sender: Button) {
        hideAllGoThrough()
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ShareCodeInfoView") as! ShareCodeInfoView
        //self.navigationController?.pushViewController(vc, animated: false)
        self.present(vc, animated: false, completion: nil)
    }
    
    func showGoThroughFromStart() {
        goThroughViewMain.isHidden = false
        goThroughBG.isHidden = false
        goThrough1.isHidden = false
        goThrough2.isHidden = true
    }
    
    func hideAllGoThrough()
    {
        goThroughBG.isHidden = true
        goThroughViewMain.isHidden = true
        goThrough1.isHidden = true
        goThrough2.isHidden = true
        
    }
}


extension HomeConsumerVC : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
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
