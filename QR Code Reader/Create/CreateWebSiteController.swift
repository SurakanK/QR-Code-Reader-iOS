//
//  CreateWebSiteController.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 7/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CreateWebSiteController: UIViewController {
        
    var imageicon = #imageLiteral(resourceName: "Website-1")

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
        textField.attributedPlaceholder = NSAttributedString(string: "Google", attributes: [NSAttributedString.Key.font : UIFont.NunitoSansRegular(size: 17), NSAttributedString.Key.foregroundColor:  UIColor.systemGray ])
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
    
    let Title_URL: UILabel = {
        let label = UILabel()
        label.text = "URL"
        label.textColor = UIColor.PrimaryColor
        label.font = UIFont.NunitoSansBlack(size: 22)
        label.numberOfLines = 0
        return label
    }()
    
    let image_LogoURL: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Website").withTintColor(UIColor.PrimaryColor!)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let textField_URL: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "www.google.com", attributes: [NSAttributedString.Key.font : UIFont.NunitoSansRegular(size: 17), NSAttributedString.Key.foregroundColor:  UIColor.systemGray ])
        textField.textColor = .black
        textField.textContentType = .URL
        textField.autocapitalizationType = .none
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
        textField.keyboardType = .URL
        return textField
    }()
    
    let image_LogoError_Field_URL: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Alert").withTintColor(UIColor.systemRed)
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        return image
    }()
    
    let viewMainBtnIcon: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let Btn_iconWeb: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.AccentColor
        button.layer.cornerRadius = 10
        button.setImage(#imageLiteral(resourceName: "Website-1"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.PrimaryColor
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.AccentColor?.cgColor
        button.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 6
        button.addTarget(self, action: #selector(ButtonIconClicker), for: .touchUpInside)
        return button
    }()
    
    let Btn_iconFacebook: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10
        button.setImage(#imageLiteral(resourceName: "facebook"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.PrimaryColor
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.AccentColor?.cgColor
        button.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 6
        button.addTarget(self, action: #selector(ButtonIconClicker), for: .touchUpInside)
        return button
    }()
    
    let Btn_iconIG: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10
        button.setImage(#imageLiteral(resourceName: "Instagram"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.PrimaryColor
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.AccentColor?.cgColor
        button.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 6
        button.addTarget(self, action: #selector(ButtonIconClicker), for: .touchUpInside)
        return button
    }()
    
    let Btn_iconTwitter: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10
        button.setImage(#imageLiteral(resourceName: "Twitter"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.PrimaryColor
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.AccentColor?.cgColor
        button.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 6
        button.addTarget(self, action: #selector(ButtonIconClicker), for: .touchUpInside)
        return button
    }()
    
    let Btn_iconLine: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10
        button.setImage(#imageLiteral(resourceName: "Line"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.PrimaryColor
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.AccentColor?.cgColor
        button.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 6
        button.addTarget(self, action: #selector(ButtonIconClicker), for: .touchUpInside)
        return button
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
        navigationItem.title = "Website"
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
        
        view.addSubview(image_LogoURL)
        view.addSubview(Title_URL)
        image_LogoURL.anchor(textField_Subject.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 25, heightConstant: 25)
        Title_URL.anchor(image_LogoURL.topAnchor, left: image_LogoURL.rightAnchor, bottom: image_LogoURL.bottomAnchor, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(textField_URL)
        textField_URL.addSubview(image_LogoError_Field_URL)
        textField_URL.anchor(image_LogoURL.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 40)
        image_LogoError_Field_URL.anchor(textField_URL.topAnchor, left: nil, bottom: textField_URL.bottomAnchor, right: textField_URL.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: 20, heightConstant: 0)
        
        view.addSubview(viewMainBtnIcon)
        viewMainBtnIcon.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        viewMainBtnIcon.anchor(textField_URL.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(Btn_iconWeb)
        view.addSubview(Btn_iconFacebook)
        view.addSubview(Btn_iconIG)
        view.addSubview(Btn_iconTwitter)
        view.addSubview(Btn_iconLine)
        Btn_iconWeb.anchor(viewMainBtnIcon.topAnchor, left: viewMainBtnIcon.leftAnchor, bottom: viewMainBtnIcon.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 45, heightConstant: 45)
        Btn_iconFacebook.anchor(viewMainBtnIcon.topAnchor, left: Btn_iconWeb.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 45, heightConstant: 45)
        Btn_iconIG.anchor(viewMainBtnIcon.topAnchor, left: Btn_iconFacebook.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 45, heightConstant: 45)
        Btn_iconTwitter.anchor(viewMainBtnIcon.topAnchor, left: Btn_iconIG.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 45, heightConstant: 45)
        Btn_iconLine.anchor(viewMainBtnIcon.topAnchor, left: Btn_iconTwitter.rightAnchor, bottom: nil, right: viewMainBtnIcon.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 45, heightConstant: 45)
        
        textField_URL.delegate = self
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
        Google_Ads_banner.anchor(viewMainBtnIcon.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 30, leftConstant: 20, bottomConstant: 10, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
    }
    
    @objc func BackButtonClicker(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func ConfirmButtonClicker(){
        
        let textUrl = textField_URL.text
        let textSubject = textField_Subject.text
        
        //Check text field url
        if !textUrl!.isEmpty{
            
            let viewPresent = DetailWebController()
            viewPresent.StateView = "Create"
            viewPresent.TextSubject = textSubject!
            viewPresent.TextUrl = textUrl!
            viewPresent.imageicon = imageicon
            viewPresent.Date = GetDate()
            
            navigationController?.pushViewController(viewPresent, animated: true)
            
        }else{
            Create_AlertMessage(Title: "amiss", TitleColor: UIColor.AccentColor!, Message: "Please fill in url website information")
            image_LogoError_Field_URL.isHidden = false
        }
    }
    
    @objc func ButtonIconClicker(sender:UIButton){
        
        let Btn_list = [Btn_iconWeb, Btn_iconFacebook, Btn_iconIG, Btn_iconTwitter, Btn_iconLine]
        for button in Btn_list{
            if sender == button{
                button.backgroundColor = UIColor.AccentColor
                imageicon = button.image(for: .normal)!
            }else{
                button.backgroundColor = UIColor.white
            }
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

extension CreateWebSiteController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
       
        if textField == textField_URL{
            
            if !textField_URL.text!.isEmpty{
                image_LogoError_Field_URL.isHidden = true
            }else{
                image_LogoError_Field_URL.isHidden = false
            }
        }
        
    }
}

extension CreateWebSiteController : GADBannerViewDelegate{
    
    // Tells the delegate an ad request loaded an ad.
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        
        view.addSubview(btn_CloseAds)
        btn_CloseAds.anchor(Google_Ads_banner.topAnchor, left: nil, bottom: nil, right: Google_Ads_banner.rightAnchor, topConstant: -25, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
    }
    
}

