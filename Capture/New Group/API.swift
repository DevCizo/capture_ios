//
//  API.swift
//  HRN
//
//  Created by Hitesh Thummar on 25/06/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation


struct AppUrl
{
    static let base_url = "http://18.220.161.197/ic/api/"
}

let SUCCESS = "success"



class APICall: NSObject
{
    
    class func call_API_ALL(url:String,param:[String:Any],handlerCompletion:@escaping (_ resDict:NSDictionary) -> Void) {
        
        print("Send URL:---->\(url)");
        print("Send Dict:---->\(param)");
        
        if isConnectedToNetwork() == false
        {
            let dict = ["success":false,"message":"No internet available."] as [String : Any]
            handlerCompletion(dict as NSDictionary)
        }
        
        Alamofire.request(url, method: .post, parameters: param).responseJSON { response in
            
            
            //            guard (response.result.value as? JSON) != nil else {
            //
            //                print("parsing fail")
            //                return
            //
            //            }
            
            // print(response.error)
            let finalJSON = try? JSON(data: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
            if let dict = finalJSON?.dictionaryObject! as NSDictionary?
            {
                print("Receive Dict:---->\(dict)");
                handlerCompletion(dict);
            }
            else
            {
                let dict = ["success":false]
                handlerCompletion(dict as NSDictionary)
            }
        }
    }
    
    class func call_API_ImageUpload(url:String,param:[String:Any],doc:[(parameter_name:String,data:Data,type:String)],handlerCompletion:@escaping (_ resDict:NSDictionary) -> Void)
    {
        
        print("Send URL:---->\(url)");
        print("Send Dict:---->\(param)");
        
        if isConnectedToNetwork() == false
        {
            let dict = ["status":false,"message":"No internet available."] as [String : Any]
            handlerCompletion(dict as NSDictionary)
        }
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for(key,value) in param
            {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            for media in doc
            {
                if media.type == "image"
                {
                    multipartFormData.append(media.data, withName: media.parameter_name, fileName: "1.png", mimeType: "image/jpeg");
                }
            }
            
        }, to: URL(string: url)!) { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })
                
                upload.responseJSON { response in
                    
                    let finalJSON = try? JSON(data: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    if let dict = finalJSON?.dictionaryObject! as NSDictionary?
                    {
                        print("Receive Dict:---->\(dict)");
                        handlerCompletion(dict);
                    }
                    else
                    {
                        let dict = ["success":false]
                        handlerCompletion(dict as NSDictionary)
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError.localizedDescription);
                break
            }
        }
    }
    
    
    class func call_API_GooglePlace(param:[String:Any],handlerCompletion:@escaping (_ resDict:NSDictionary) -> Void) {
        
        
        
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(param["lat"] ?? 0),\(param["long"] ?? 0)&radius=1500&type=restaurant&keyword=\(param["keyword"] ?? "")&key=\(GOOGLE_MAP_KEY)&pagetoken=\(param["nextToken"] ?? "")"
        
        print("Send Url:---->\(url)");
        print("Send Dict:---->\(param)");
        
        
        if isConnectedToNetwork() == false
        {
            let dict = ["success":false,"message":"No internet available."] as [String : Any]
            handlerCompletion(dict as NSDictionary)
        }
        
        Alamofire.request(url, method: .post, parameters: param).responseJSON { response in
            
            
            //            guard (response.result.value as? JSON) != nil else {
            //
            //                print("parsing fail")
            //                return
            //
            //            }
            
            // print(response.error)
            let finalJSON = try? JSON(data: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
            if let dict = finalJSON?.dictionaryObject! as NSDictionary?
            {
                print("Receive Dict:---->\(dict)");
                handlerCompletion(dict);
            }
            else
            {
                let dict = ["success":false]
                handlerCompletion(dict as NSDictionary)
            }
        }
    }
    
    class func getRouteForGoogleMap(source:CLLocationCoordinate2D,destination:CLLocationCoordinate2D,handlerCompletion:@escaping (_ path:String) -> Void) {
        
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&mode=driving&key=\(GOOGLE_MAP_KEY)"
        
        Alamofire.request(url, method: .get, parameters: nil).responseJSON { response in
            
            let finalJSON = try? JSON(data: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
            
            if let dict = finalJSON?.dictionaryObject! as NSDictionary?
            {
                if let array = dict["routes"] as? NSArray,array.count > 0
                {
                    let dict = array[0] as! NSDictionary
                    let dict1 = dict["overview_polyline"] as! NSDictionary
                    
                    let path = dict1["points"] as! String
                    handlerCompletion(path)
                }
            }
        }
    }
    
    
    
    class func isConnectedToNetwork()->Bool{
        
         return NetworkReachabilityManager()!.isReachable
        
    }
}


