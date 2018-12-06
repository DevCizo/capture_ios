//
//  Constant.swift

//
//  Created by Hitesh Thummar on 29/01/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit
import CoreLocation

let APP_URL = "https://itunes.apple.com/us/app/apple-store/id1444771083?mt=8"

let GOOGLE_MAP_KEY = "AIzaSyD9pL2exuvOATS6fj8lWwsXIhCbCKfbeK8"
var userLocation:CLLocationCoordinate2D!


var userDict:NSDictionary!
var USERID = ""



var isConsumerInSignUpLogin = true
var isConsumer = true

let TCLink = "http://18.224.72.253/terms-and-condition"

let FONT_SF_DISPLAY_REGULAR = "SFProDisplay-Regular"
let FONT_SF_DISPLAY_MEDIUM = "SFProDisplay-Medium"
let FONT_SF_DISPLAY_BOLD = "SFProDisplay-Bold"
let FONT_SF_DISPLAY_SEMI_BOLD = "SFProDisplay-Semibold"
let FONT_SF_DISPLAY_LIGHT = "SFProDisplay-Light"



let SCREEN_SIZE = UIScreen.main.bounds;
let NOTIFICATIONCENTER = NotificationCenter.default;
let USERDEFAULTS = UserDefaults.standard;

let COLOR_PINK = "FB6882"
let BACKGROUND_COLOR = "E9ECF6"

let is_Ipad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)

let iPhone4 = UIScreen.main.sizeType == .iPhone4
let iPhone5_SE = UIScreen.main.sizeType == .iPhone5_Se
let iPhone6_6s_7_8 = (UIScreen.main.sizeType == .iPhone6_6s_7_8)
let iPhone6_6s_7_8_Plus = (UIScreen.main.sizeType == .iPhone6_6s_7_8_Plus)
let iPhoneX_XS = (UIScreen.main.sizeType == .iPhoneX_XS)
let iPhoneXR = (UIScreen.main.sizeType == .iPhoneXR)
let iPhoneXS_MAX = (UIScreen.main.sizeType == .iPhoneXS_MAX)
let IphoneWithNotch  =  (iPhoneX_XS || iPhoneXR || iPhoneXS_MAX)





