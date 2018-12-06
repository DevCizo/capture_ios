//
//  SessionConsumerVC.swift
//  Capture
//
//  Created by Hitesh Thummar on 30/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import CropViewController

class ProfileInfoAddPhotographerVC: UIViewController {

    var imagePickerController:UIImagePickerController!

    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var txtName: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtInsta: UITextField!
    @IBOutlet weak var txtfb: UITextField!
    @IBOutlet weak var txtTwitter: UITextField!
    
    @IBOutlet weak var bestWorkScroll: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(ovalIn: CGRect(x: userImg.frame.origin.x - 5, y: userImg.frame.origin.y - 5, width: userImg.frame.size.width + 10, height: userImg.frame.size.height + 10)).cgPath
        circleLayer.lineWidth = 1.0
        circleLayer.strokeColor = fromIntToColor(red: 27, green: 27, blue: 27, alpha: 1).cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineJoin = kCALineJoinRound
        circleLayer.lineDashPattern = [4, 4]
        // self.bgImage is parentView
        userImg.superview?.layer.addSublayer(circleLayer)
        
        
        txtInsta.setLeftPaddingPoints(30)
        txtInsta.setRightPaddingPoints(20)
        
        txtfb.setLeftPaddingPoints(30)
        txtfb.setRightPaddingPoints(20)
        
        txtTwitter.setLeftPaddingPoints(30)
        txtTwitter.setRightPaddingPoints(20)

        var x:CGFloat = 0
        
        for i in 0..<4
        {
            let button = UIButton(frame: CGRect(x: x, y: 0, width: 46, height: 46))
            button.setBackgroundImage(#imageLiteral(resourceName: "sessionPicImg"), for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            bestWorkScroll.addSubview(button)
            x = x + 46 + 12;
            button.setCornerRadious(radious: 5)
        }
        bestWorkScroll.contentSize = CGSize(width: x, height: 46)
        
        
        
        
    }

    
    @IBAction func btnUploadPic(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "", message: "Choose image.", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Make photo", style: .default , handler:{ (UIAlertAction)in
            
            self.imagePickerController = UIImagePickerController()
            self.imagePickerController.sourceType = .camera
            self.imagePickerController.delegate = self;
            self.present(self.imagePickerController, animated: true, completion: nil)
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default , handler:{ (UIAlertAction)in
            
            self.imagePickerController = UIImagePickerController()
            self.imagePickerController.sourceType = .photoLibrary
            self.imagePickerController.delegate = self;
            self.present(self.imagePickerController, animated: true, completion: nil)
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        if is_Ipad
        {
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }
        else
        {
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }

        
    }
    
    @IBAction func btnConfirm(_ sender: Button) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "VerifyMobileVC") as! VerifyMobileVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func btnBack(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
    
}



extension ProfileInfoAddPhotographerVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        dismiss(animated:true, completion: nil) //5
        
        let vc = CropViewController(croppingStyle: .circular, image: chosenImage)
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
}


extension ProfileInfoAddPhotographerVC:CropViewControllerDelegate
{
   
    
    public func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {

        print("done")
        userImg.image = image
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    
   
    
}

