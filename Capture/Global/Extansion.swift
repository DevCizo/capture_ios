//
//  Global.swift
//  Sample App
//
//  Created by Hitesh Thummar on 14/07/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

//https://stackoverflow.com/questions/9388372/how-to-show-an-activity-indicator-in-sdwebimage


import UIKit
import Toaster
import SVProgressHUD
import SDWebImage



extension Int {
    func toString() -> String {
        return "\(self)"
    }
}
extension String {
    
    func isStringEmpty() -> Bool {
        return self.trimWhiteSpace().count == 0 ? true : false
    }
    
    
    func isValidEmail() -> Bool {
        let emailRegression = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let predicate = NSPredicate(format: "self matches %@", emailRegression)
        return predicate.evaluate(with: self)
    }
    
    
    func isValidString() -> Bool {
        if self == "<null>" || self == "(null)" || self == "null" {
            return false
        }
        return true
    }
    
    
    
    func isValidUrl () -> Bool {
        
        var url = self;
        
        if !url.hasPrefix("https://") || !url.hasPrefix("http://"){
            url = "http://\(url)"
        }
        
        if let url = URL(string: url) {
            // check if your application can open the NSURL instance
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    
    mutating func removeSubString(subString: String) -> String {
        if self.contains(subString) {
            guard let stringRange = self.range(of: subString) else { return self }
            return self.replacingCharacters(in: stringRange, with: "")
        }
        return self
    }
    
    func trimWhiteSpaceAndNewLine() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    func trimWhiteSpace() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}

func fromIntToColor(red:Int,green:Int,blue:Int,alpha:CGFloat) ->UIColor
{
    return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
}


extension UITextField {
    
    func setFontSize (size:Int) {
        self.font =  UIFont(name: self.font!.fontName, size:CGFloat(size))!
    }
    
    
    func setLeftViewIcon(icon: UIImage) {
        //        let btnView = UIButton(frame: CGRect(x: 0, y: 0, width: ((self.frame.height) * 0.50), height: ((self.frame.height) * 0.50)))
        let btnView = UIButton(frame: CGRect(x: 0, y: 0, width: ((self.frame.height) * 1), height: ((self.frame.height) * 1)))
        btnView.setImage(icon, for: .normal)
        btnView.imageEdgeInsets = UIEdgeInsets(top: 13, left: 5, bottom: 5, right: 3)
        btnView.imageView?.contentMode = .scaleAspectFit
        self.leftViewMode = .always
        self.leftView = btnView
    }
    
    func setLeftViewIconWithTopPadding(icon: UIImage,topPadding:Int,heightScale:CGFloat) {
        //        let btnView = UIButton(frame: CGRect(x: 0, y: 0, width: ((self.frame.height) * 0.50), height: ((self.frame.height) * 0.50)))
        let btnView = UIButton(frame: CGRect(x: 0, y: 0, width: ((self.frame.height) * heightScale), height: ((self.frame.height) * heightScale)))
        btnView.setImage(icon, for: .normal)
        btnView.imageEdgeInsets = UIEdgeInsets(top: CGFloat(topPadding), left: CGFloat(topPadding), bottom: CGFloat(topPadding), right: 3)
        btnView.imageView?.contentMode = .scaleAspectFit
        self.leftViewMode = .always
        self.leftView = btnView
    }
    
    
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
    
    
    
    
}


extension UIButton {
    func setFontSize (size:Int) {
        self.titleLabel?.font = UIFont(name: self.titleLabel!.font!.fontName, size:CGFloat(size))!
    }

    
}
extension UILabel {
    func setFontSize (size:Int) {
        self.font =  UIFont(name: self.font!.fontName, size:CGFloat(size))!
    }
    
    func addCharactersSpacing(_ value: CGFloat = 1.5) {
        if let textString = text {
            let attrs: [NSAttributedStringKey : Any] = [.kern: value]
            attributedText = NSAttributedString(string: textString, attributes: attrs)
        }
    }
}


extension StringProtocol where Index == String.Index {
    func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    func ranges<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> [Range<Index>] {
        var ranges: [Range<Index>] = []
        var start: Index = startIndex
        
        while let range = range(of: string, options: options, range: start..<endIndex) {
            ranges.append(range)
            start = range.upperBound
        }
        
        return ranges
    }
}



//MARK: -device type
extension UIScreen {
    
    enum SizeType: CGFloat {
        case Unknown = 0.0
        case iPhone4 = 960.0
        case iPhone5_Se = 1136.0
        case iPhone6_6s_7_8 = 1334.0
        case iPhone6_6s_7_8_Plus = 2208.0
        case iPhoneX_XS = 2436.0
        case iPhoneXR = 1792.0
        case iPhoneXS_MAX = 2688.0
        
    }
    
    var sizeType: SizeType {
        let height = nativeBounds.height
        guard let sizeType = SizeType(rawValue: height) else { return .Unknown }
        return sizeType
    }
    
    /*
     if UIScreen.main.sizeType == .iPhoneX
     {}
     */
}


extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }

    func setCornerRadious(radious:CGFloat)
    {
        self.layer.cornerRadius = radious
        self.layer.masksToBounds = true
    }
    
    func setBorder(width:CGFloat,color:UIColor)
    {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
}





//MARK:- UIColor
extension UIColor {
    convenience init(hex: String,alpha:CGFloat) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: alpha
        )
    }
}

//MARK:- toster

func showToastMessage(msg:String)
{
    Toast(text: msg).show()
}
//MARK:- Blur
extension UIView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
    func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
            blurView.removeFromSuperview()
        }
    }
}

//MARK:- Image Loader

extension UIImageView
{
    func loadImageWithURL(url:String)
    {
        if let imgurl = URL(string: url)
        {
            self.sd_setImage(with: imgurl, placeholderImage: nil, options: [.refreshCached], completed: { (img, err, type, u) in
            })
        }
    }
}



//MARK:- Loader

func showLoader()
{
    SVProgressHUD.show()
    UIApplication.shared.beginIgnoringInteractionEvents()
}

func hideLoader()
{
    UIApplication.shared.endIgnoringInteractionEvents()
    DispatchQueue.main.async(execute: {() -> Void in
        SVProgressHUD.dismiss()
    })
}

extension UILabel
{
    func addImage(imageName: String, afterLabel bolAfterLabel: Bool = false)
    {
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
        
        if (bolAfterLabel)
        {
            let strLabelText: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
            strLabelText.append(attachmentString)
            
            self.attributedText = strLabelText
        }
        else
        {
            let strLabelText: NSAttributedString = NSAttributedString(string: self.text!)
            let mutableAttachmentString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)
            
            self.attributedText = mutableAttachmentString
        }
    }
    
    func removeImage()
    {
        let text = self.text
        self.attributedText = nil
        self.text = text
    }
}




extension UIImage {
    
    
    func resize(withWidth newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func scaleUIImageToSize(size: CGSize) -> UIImage {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
}


extension Data {
    func sizeString(units: ByteCountFormatter.Units = [.useKB], countStyle: ByteCountFormatter.CountStyle = .file) -> String {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = units
        bcf.countStyle = .file
        
        
        var str = bcf.string(fromByteCount: Int64(count))
        str = str.replacingOccurrences(of: "KB", with: "")
        str = str.replacingOccurrences(of: " ", with: "")
        str = str.replacingOccurrences(of: ",", with: "")
        
        return str
    }
    
}





extension UIApplication {
    static func cacheDirectory() -> URL {
        guard let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            fatalError("unable to get system cache directory - serious problems")
        }
        
        return cacheURL
    }
    
    static func documentsDirectory() -> URL {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("unable to get system docs directory - serious problems")
        }
        
        return documentsURL
    }
}


/*
 let targetURL = Bundle.main.url(forResource: "11", withExtension: "pdf")!
 
 let data = try! Data(contentsOf: targetURL)
 print(data)
 document = UIDocument(fileURL: targetURL);
 
 
 try! document?.writeContents(data, andAttributes: [:], safelyTo: UIApplication.documentsDirectory().appendingPathComponent("1.pdf"), for: UIDocumentSaveOperation.forOverwriting)
 */

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func blink() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.isRemovedOnCompletion = false
        animation.fromValue           = 1
        animation.toValue             = 0.1
        animation.duration            = 0.8
        animation.autoreverses        = true
        animation.repeatCount         = 5000
        animation.beginTime           = CACurrentMediaTime() + 0.5
        self.layer.add(animation, forKey: nil)
    }
    
    
    
}


extension Date
{
    func toDateString(formate:String) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: self) // string purpose I add here
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = formate//"yyyy-MM-dd"
        return formatter.string(from: yourDate!)
    }
    
    func toTimeString(formate:String) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: self) // string purpose I add here
        print(myString)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = formate//"yyyy-MM-dd"
        return formatter.string(from: yourDate!)
    }
    
    func getCurrentDateWithFormat(format:String) -> String {
        
        let dateFormatter = DateFormatter()
        // dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        dateFormatter.dateFormat = format
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
        
    }
}

public extension UITableView {
    
    func registerCellClass(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        self.register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func registerCellNib(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func registerHeaderFooterViewClass(_ viewClass: AnyClass) {
        let identifier = String.className(viewClass)
        self.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func registerHeaderFooterViewNib(_ viewClass: AnyClass) {
        let identifier = String.className(viewClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
}

extension UIApplication {
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        
        if let slide = viewController as? SlideMenuController {
            return topViewController(slide.mainViewController)
        }
        return viewController
    }
}


extension Notification.Name
{
    //consumer
    static let openInviteConsumer = Notification.Name(rawValue: "openInviteConsumer")
    static let openSessionConsumer = Notification.Name(rawValue: "openSessionConsumer")
    static let openNotificationConsumer = Notification.Name(rawValue: "openNotificationConsumer")
    static let openProfileConsumer = Notification.Name(rawValue: "openProfileConsumer")
    static let openPaymentConsumer = Notification.Name(rawValue: "openPaymentMethodConsumer")
    
    // photographer
    
    static let openProfilePhotographer = Notification.Name(rawValue: "openProfilePhotographer")
    static let openSessionPhotographer = Notification.Name(rawValue: "openSessionPhotographer")
    static let openNotificationPhotographer = Notification.Name(rawValue: "openNotificationPhotographer")
    static let openBalancePhotographer = Notification.Name(rawValue: "openBalancePhotographer")
}

extension UIViewController {
    
    func pop(numberOfTimes: Int) {
        guard let navigationController = navigationController else {
            return
        }
        let viewControllers = navigationController.viewControllers
        let index = numberOfTimes + 1
        if viewControllers.count >= index {
            navigationController.popToViewController(viewControllers[viewControllers.count - index], animated: true)
        }
    }
}


extension UIViewController {
    
    func findSpecificVC(className:String) {
        guard let navigationController = navigationController else {
            return
        }
        let viewControllers = navigationController.viewControllers
       
            for viewController in viewControllers {
                // some process
                if viewController.isKind(of: NSClassFromString(className)!) {
                    print("yes it is")
                }
            
        }
    }
}


