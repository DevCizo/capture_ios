//
//  PhotographerRequestListCell.swift
//  Capture
//
//  Created by Hitesh Thummar on 03/12/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit
import GoogleMaps
class PhotographerRequestListView: UIView {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mapContainerView: UIView!
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var lnlName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnReject: UIButton!
    
    
    @IBOutlet weak var CSAddressHeight: NSLayoutConstraint!
    
    
    var mapview: GMSMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    
    @IBAction func showMap(_ sender: UIButton) {
        
        mapview = GMSMapView(frame: mapContainerView.frame)
        mapContainerView.addSubview(mapview)
        
        
        APICall.getRouteForGoogleMap(source: CLLocationCoordinate2D(latitude: 38.909772, longitude: -86.508327), destination: CLLocationCoordinate2D(latitude: 37.414618, longitude: -79.437344)) {[weak self] (route) in
            
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.drawPathOnMap(pathStr: route, map: strongSelf.mapview)
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
        marker.map = mapview
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
