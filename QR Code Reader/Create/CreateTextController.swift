//
//  CreateTextController.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 7/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CreateTextController: UIViewController {
    
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
        textField.attributedPlaceholder = NSAttributedString(string: "note", attributes: [NSAttributedString.Key.font : UIFont.NunitoSansRegular(size: 17), NSAttributedString.Key.foregroundColor:  UIColor.systemGray ])
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
    
    let Title_Text: UILabel = {
        let label = UILabel()
        label.text = "Text"
        label.textColor = UIColor.PrimaryColor
        label.font = UIFont.NunitoSansBlack(size: 22)
        label.numberOfLines = 0
        return label
    }()
    
    let image_LogoText: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Text").withTintColor(UIColor.PrimaryColor!)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let textView_Text: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.tintColor = UIColor.AccentColor
        textView.font = UIFont.NunitoSansRegular(size: 17)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 30)
        textView.layer.cornerRadius = 10
        return textView
    }()
    
    let main_textView_Text: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 6
        return view
    }()
    
    let image_LogoError_view_Text: UIImageView = {
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
        navigationItem.title = "Text"
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
        
        view.addSubview(image_LogoText)
        view.addSubview(Title_Text)
        image_LogoText.anchor(textField_Subject.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 25, heightConstant: 25)
        Title_Text.anchor(image_LogoText.topAnchor, left: image_LogoText.rightAnchor, bottom: image_LogoText.bottomAnchor, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(main_textView_Text)
        main_textView_Text.addSubview(textView_Text)
        main_textView_Text.addSubview(image_LogoError_view_Text)
        main_textView_Text.anchor(image_LogoText.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 200)
        textView_Text.anchor(main_textView_Text.topAnchor, left: main_textView_Text.leftAnchor, bottom: main_textView_Text.bottomAnchor, right: main_textView_Text.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        image_LogoError_view_Text.anchor(textView_Text.topAnchor, left: nil, bottom: nil, right: textView_Text.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 20, heightConstant: 20)
        
        textView_Text.delegate = self
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
        Google_Ads_banner.anchor(textView_Text.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 30, leftConstant: 20, bottomConstant: 10, rightConstant: 20, widthConstant: 0, heightConstant: 0)
    }
    
    @objc func BackButtonClicker(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func ConfirmButtonClicker(){
        
        //Check text view
        if !textView_Text.text!.isEmpty{
        
            let textSubject = textField_Subject.text
            let textView = textView_Text.text
              
            let viewPresent = DetailTextController()
            viewPresent.StateView = "Create"
            viewPresent.TextSubject = textSubject!
            viewPresent.TextView = textView!
            viewPresent.Date = GetDate()
            
            navigationController?.pushViewController(viewPresent, animated: true)
            
        }else{
            image_LogoError_view_Text.isHidden = false
            Create_AlertMessage(Title: "amiss", TitleColor: UIColor.AccentColor!, Message: "Please fill in text.")
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

extension CreateTextController: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == textView_Text{
            if !textView_Text.text!.isEmpty{
                image_LogoError_view_Text.isHidden = true
            }else{
                image_LogoError_view_Text.isHidden = false
            }
        }
    }
    
}

extension CreateTextController : GADBannerViewDelegate{
    
    // Tells the delegate an ad request loaded an ad.
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        
        view.addSubview(btn_CloseAds)
        btn_CloseAds.anchor(Google_Ads_banner.topAnchor, left: nil, bottom: nil, right: Google_Ads_banner.rightAnchor, topConstant: -25, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
    }
    
}
