//
//  CreateWiFiController.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 7/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CreateWiFiController: UIViewController {
    
    var encryption = "WPA"
    
    var Google_Ads_banner: GADBannerView!

    let Title_Subject: UILabel = {
        let label = UILabel()
        label.text = "Subject"
        label.textColor = UIColor.PrimaryColor
        label.font = UIFont.NunitoSansBlack(size: 22)
        label.numberOfLines = 0
        return label
    }()
    
    let image_LogoSubject: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Title").withTintColor(UIColor.PrimaryColor!)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let textField_Subject: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "my home WiFi", attributes: [NSAttributedString.Key.font : UIFont.NunitoSansRegular(size: 17), NSAttributedString.Key.foregroundColor:  UIColor.systemGray ])
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.tintColor = UIColor.AccentColor
        textField.font = UIFont.NunitoSansRegular(size: 17)
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        textField.rightViewMode = UITextField.ViewMode.always
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 10
        textField.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        textField.layer.shadowOffset = CGSize(width: 3, height: 3)
        textField.layer.shadowRadius = 2
        textField.layer.shadowOpacity = 6
        return textField
    }()
    
    let Title_SSID: UILabel = {
        let label = UILabel()
        label.text = "SSID"
        label.textColor = UIColor.PrimaryColor
        label.font = UIFont.NunitoSansBlack(size: 22)
        label.numberOfLines = 0
        return label
    }()
    
    let image_LogoSSID: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "WiFi").withTintColor(UIColor.PrimaryColor!)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let textField_SSID: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "HomeWiFi_5G", attributes: [NSAttributedString.Key.font : UIFont.NunitoSansRegular(size: 17), NSAttributedString.Key.foregroundColor:  UIColor.systemGray ])
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.tintColor = UIColor.AccentColor
        textField.font = UIFont.NunitoSansRegular(size: 17)
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        textField.rightViewMode = UITextField.ViewMode.always
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 10
        textField.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        textField.layer.shadowOffset = CGSize(width: 3, height: 3)
        textField.layer.shadowRadius = 2
        textField.layer.shadowOpacity = 6
        return textField
    }()
    
    let image_LogoError_Field_SSID: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Alert").withTintColor(UIColor.systemRed)
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        return image
    }()
    
    let image_LogoEncryption: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Encryption").withTintColor(UIColor.PrimaryColor!)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let Title_Encryption: UILabel = {
        let label = UILabel()
        label.text = "Encryption"
        label.textColor = UIColor.PrimaryColor
        label.font = UIFont.NunitoSansBlack(size: 22)
        label.numberOfLines = 0
        return label
    }()
    
    let view_Segmented: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 6
        return view
    }()
    
    let SegmentedControl : UISegmentedControl = {
        let Segment = UISegmentedControl(items: ["WPA/WPA2","WEP","None"])
        Segment.selectedSegmentIndex = 0
        Segment.selectedSegmentTintColor = UIColor.AccentColor
        Segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font : UIFont.NunitoSansBold(size: 15)], for: .normal)
        Segment.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        return Segment
    }()
    
    let image_LogoPassword: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Key").withTintColor(UIColor.PrimaryColor!)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let Title_Password: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = UIColor.PrimaryColor
        label.font = UIFont.NunitoSansBlack(size: 22)
        label.numberOfLines = 0
        return label
    }()
    
    let textField_Password: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.font : UIFont.NunitoSansRegular(size: 17), NSAttributedString.Key.foregroundColor:  UIColor.systemGray ])
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.tintColor = UIColor.AccentColor
        textField.font = UIFont.NunitoSansRegular(size: 17)
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        textField.rightViewMode = UITextField.ViewMode.always
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 10
        textField.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        textField.layer.shadowOffset = CGSize(width: 3, height: 3)
        textField.layer.shadowRadius = 2
        textField.layer.shadowOpacity = 6
        return textField
    }()
    
    let image_LogoError_Field_Password: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Alert").withTintColor(UIColor.systemRed)
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        return image
    }()
    
    let btn_CloseAds: UIButton = {
       let button = UIButton(type: .system)
       button.backgroundColor = .clear
       button.setImage(#imageLiteral(resourceName: "Cross"), for: .normal)
       button.imageView?.contentMode = .scaleAspectFit
       button.tintColor = UIColor.systemRed
       button.addTarget(self, action: #selector(CloseAdsButtonClicker), for: .touchUpInside)
       return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.SecondaryColor
        
        SettingNavigetion()
        settingElement()
        SettingGoogleAdsBanner()
    }
    
    func SettingNavigetion(){
        
        //set navigation Controller
        navigationItem.title = "WiFi"
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor.PrimaryColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.NunitoSansBlack(size: 26)]
          
        //set navigationItem leftBarButton
        let leftBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow"), style: .plain, target: self, action: #selector(BackButtonClicker))
        leftBarButton.imageInsets = UIEdgeInsets(top: -3, left: -5, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        //set navigationItem rightBarButton
        let rightBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Check"), style: .plain, target: self, action: #selector(ConfirmButtonClicker))
        rightBarButton.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: 0, right: -5)
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func settingElement(){
        
        view.addSubview(image_LogoSubject)
        view.addSubview(Title_Subject)
        image_LogoSubject.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 25, heightConstant: 25)
        Title_Subject.anchor(image_LogoSubject.topAnchor, left: image_LogoSubject.rightAnchor, bottom: image_LogoSubject.bottomAnchor, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(textField_Subject)
        textField_Subject.anchor(image_LogoSubject.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 40)
        
        view.addSubview(image_LogoSSID)
        view.addSubview(Title_SSID)
        image_LogoSSID.anchor(textField_Subject.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 25, heightConstant: 25)
        Title_SSID.anchor(image_LogoSSID.topAnchor, left: image_LogoSSID.rightAnchor, bottom: image_LogoSSID.bottomAnchor, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(textField_SSID)
        textField_SSID.addSubview(image_LogoError_Field_SSID)
        textField_SSID.anchor(image_LogoSSID.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 40)
        image_LogoError_Field_SSID.anchor(textField_SSID.topAnchor, left: nil, bottom: textField_SSID.bottomAnchor, right: textField_SSID.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: 20, heightConstant: 0)
        
        view.addSubview(image_LogoEncryption)
        view.addSubview(Title_Encryption)
        image_LogoEncryption.anchor(textField_SSID.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 25, heightConstant: 25)
        Title_Encryption.anchor(image_LogoEncryption.topAnchor, left: image_LogoEncryption.rightAnchor, bottom: image_LogoEncryption.bottomAnchor, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(view_Segmented)
        view_Segmented.addSubview(SegmentedControl)
        view_Segmented.anchor(image_LogoEncryption.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 40)
        SegmentedControl.anchor(view_Segmented.topAnchor, left: view_Segmented.leftAnchor, bottom: view_Segmented.bottomAnchor, right: view_Segmented.rightAnchor, topConstant: 2, leftConstant: 2, bottomConstant: 2, rightConstant: 2, widthConstant: 0, heightConstant: 0)
        fixBackgroundSegmentControl(SegmentedControl)
        
        view.addSubview(image_LogoPassword)
        view.addSubview(Title_Password)
        image_LogoPassword.anchor(SegmentedControl.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 25, heightConstant: 25)
        Title_Password.anchor(image_LogoPassword.topAnchor, left: image_LogoPassword.rightAnchor, bottom: image_LogoPassword.bottomAnchor, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(textField_Password)
        textField_Password.addSubview(image_LogoError_Field_Password)
        textField_Password.anchor(image_LogoPassword.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 40)
        image_LogoError_Field_Password.anchor(textField_Password.topAnchor, left: nil, bottom: textField_Password.bottomAnchor, right: textField_Password.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: 20, heightConstant: 0)
        
        textField_SSID.delegate = self
        textField_Password.delegate = self
        
    }
    
    func SettingGoogleAdsBanner(){
           
        Google_Ads_banner = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        Google_Ads_banner.backgroundColor = .clear
        
        Google_Ads_banner.adUnitID = String.GADBannerID
        Google_Ads_banner.delegate = self
        Google_Ads_banner.rootViewController = self
        
        //remove ads when payment
        if PresentPage.StateRemoveAds == false{
            Google_Ads_banner.load(GADRequest())
        }
        
        view.addSubview(Google_Ads_banner)
        Google_Ads_banner.anchor(textField_Password.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 30, leftConstant: 20, bottomConstant: 10, rightConstant: 20, widthConstant: 0, heightConstant: 0)
    }
    
    //func clear backgroung segmentControl
    func fixBackgroundSegmentControl( _ segmentControl: UISegmentedControl){
        if #available(iOS 13.0, *) {
            //just to be sure it is full loaded
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                for i in 0...(segmentControl.numberOfSegments-1)  {
                    let backgroundSegmentView = segmentControl.subviews[i]
                    //it is not enogh changing the background color. It has some kind of shadow layer
                    backgroundSegmentView.isHidden = true
                }
            }
        }
    }
    
    //event segment Control when value Changed
    @objc func segmentSelected(sender: UISegmentedControl){
        let index = sender.selectedSegmentIndex
        
        switch index {
        case 0: encryption = "WPA"
        case 1: encryption = "WEP"
        case 2: encryption = "nopass"
        default:break
        }
        
        //hiden when select nopass
        if index == 2{

            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                self.image_LogoPassword.alpha = 0
                self.Title_Password.alpha = 0
                self.textField_Password.alpha = 0
            }, completion: nil)
            
        }else{
            if textField_Password.alpha == 0 {
        
                UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                    self.image_LogoPassword.alpha = 1
                    self.Title_Password.alpha = 1
                    self.textField_Password.alpha = 1
                }, completion: nil)
                
            }
        }
    }
    
    @objc func BackButtonClicker(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func ConfirmButtonClicker(){
        
        //Check text field SSID and password
        if (!textField_SSID.text!.isEmpty && !textField_Password.text!.isEmpty) ||
            (!textField_SSID.text!.isEmpty && encryption == "nopass"){
    
            let textSubject = textField_Subject.text
            let textSSID = textField_SSID.text
            let textPassword = textField_Password.text
            
            let viewPresent = DetailWifiController()
            viewPresent.StateView = "Create"
            viewPresent.TextSubject = textSubject!
            viewPresent.TextSSID = textSSID!
            viewPresent.TextPass = textPassword!
            viewPresent.encryption = encryption
            viewPresent.Date = GetDate()
            
            navigationController?.pushViewController(viewPresent, animated: true)
        
        }else{
            
            if textField_SSID.text!.isEmpty{
                image_LogoError_Field_SSID.isHidden = false
            }
            
            if textField_Password.text!.isEmpty{
                image_LogoError_Field_Password.isHidden = false
            }
            
             Create_AlertMessage(Title: "amiss", TitleColor: UIColor.AccentColor!, Message: "Please fill in SSID and Password.")
        }
    }
    
    @objc func CloseAdsButtonClicker(){
        let viewPresent = UpgradeController()
        viewPresent.StateView = "CloseAds"
        self.navigationController?.pushViewController(viewPresent, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.hidesBottomBarWhenPushed = true
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CreateWiFiController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
       
        if textField == textField_SSID{
            if !textField_SSID.text!.isEmpty{
                image_LogoError_Field_SSID.isHidden = true
            }else{
                image_LogoError_Field_SSID.isHidden = false
            }
        }else if textField == textField_Password{
            if !textField_Password.text!.isEmpty{
                image_LogoError_Field_Password.isHidden = true
            }else{
                image_LogoError_Field_Password.isHidden = false
            }
        }
        
    }
}

extension CreateWiFiController : GADBannerViewDelegate{
    
    // Tells the delegate an ad request loaded an ad.
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        
        view.addSubview(btn_CloseAds)
        btn_CloseAds.anchor(Google_Ads_banner.topAnchor, left: nil, bottom: nil, right: Google_Ads_banner.rightAnchor, topConstant: -25, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
    }
    
}
