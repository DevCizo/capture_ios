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

class RequestDetailFromRequestComeForPhotographer: UIViewController {
    
    @IBOutlet weak var mapContainerView: UIView!
    var locationManager:CLLocationManager!
    
    @IBOutlet weak var userDetailView: UIView!
    
    
    var mapView:GMSMapView!
    var userLocationMarker: GMSMarker!
    var photoLocationMarker: GMSMarker!
    
    @IBOutlet weak var CSStartSessionHeight: NSLayoutConstraint!
    @IBOutlet weak var CSStartSessionBtnWidth: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !iPhone4 || !iPhone5_SE
        {
            CSStartSessionBtnWidth.constant = 220
        }
        
        
        CSStartSessionHeight.constant = 0
        locationManager = CLLocationManager()
        
        addMap()
        self.perform(#selector(self.initLocationService), with: nil, afterDelay: 0.01)
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnOpenchat(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DialogsViewController") as! DialogsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    
    @IBAction func btnStartSession(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SessionStartPhotographerVC") as! SessionStartPhotographerVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    func addMap() {
        
        let camera = GMSCameraPosition.camera(withLatitude: 38.909772, longitude: -86.508327, zoom: 10.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapContainerView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
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
        
        
        APICall.getRouteForGoogleMap(source: CLLocationCoordinate2D(latitude: 38.909772, longitude: -86.508327), destination: CLLocationCoordinate2D(latitude: 37.414618, longitude: -79.437344)) {[weak self] (route) in
            
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.drawPathOnMap(pathStr: route, map: strongSelf.mapView)
        }
        addUserCurrentLocationMarker()
        
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
        photoLocationMarker = GMSMarker()
        photoLocationMarker.position = CLLocationCoordinate2D(latitude: 37.414618, longitude: -79.437344)
        photoLocationMarker.icon = #imageLiteral(resourceName: "mapMarker")
        photoLocationMarker.map = mapView
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
    
}

extension RequestDetailFromRequestComeForPhotographer:GMSMapViewDelegate
{
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        if CSStartSessionHeight.constant == 0
        {
            UIView.animate(withDuration: 0.2) {
                self.CSStartSessionHeight.constant = 48
                self.view.layoutSubviews()
            }
            
        }
    }
}

extension RequestDetailFromRequestComeForPhotographer: CLLocationManagerDelegate {
    
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
