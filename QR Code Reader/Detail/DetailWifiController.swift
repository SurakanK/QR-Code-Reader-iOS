//
//  DetailWifiController.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 9/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//

import UIKit
import GoogleMobileAds

class DetailWifiController: UIViewController {
   
    var StateView = ""
    var EditSubjectState = false
    
    var IDlist = ""
    var TextSubjectFirst = ""
    var TextSubject = ""
    var TextSSID = ""
    var TextPass = ""
    var TextCreateWiFi = ""
    var encryption = ""
    var FavoriteState = "false"
    var imageQR = UIImage()
    var imageicon = #imageLiteral(resourceName: "WiFi")
    var Date = "01/01/20 00:00 PM"

    var Google_Ads_banner: GADBannerView!
    var Google_Ads_interstitial_Save: GADInterstitialAd!
    var Google_Ads_interstitial_Share: GADInterstitialAd!
    var presentAds_Save = false
    var presentAds_Share = false
    
    //SQlite database
    var databaseHelper: SQLiteHelper = SQLiteHelper.init()
    
    let view_Discription: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.PrimaryColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    let view_QRCode: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 6
        return view
    }()
    
    let btn_Edit: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "Edit"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.AccentColor
        button.addTarget(self, action: #selector(EditButtonClicker), for: .touchUpInside)
        return button
    }()
    
    let btn_Favorite: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "Star_Border"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.AccentColor
        button.addTarget(self, action: #selector(FavoriteButtonClicker), for: .touchUpInside)
        return button
    }()
    
    let text_Subject: UITextField = {
        let textField = UITextField()
        textField.text = "Home WiFi"
        textField.attributedPlaceholder = NSAttributedString(string: "Untitle", attributes: [NSAttributedString.Key.font : UIFont.NunitoSansBlack(size: 22), NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.AccentColor
        textField.font = UIFont.NunitoSansBlack(size: 22)
        textField.leftViewMode = UITextField.ViewMode.always
        textField.isEnabled = false
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let text_SSID: UILabel = {
        let label = UILabel()
        label.text = "SSID : Punnumsai_5G"
        label.textColor = UIColor.white
        label.font = UIFont.NunitoSansBold(size: 17)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    let text_Password: UILabel = {
        let label = UILabel()
        label.text = "Password : 0830627675"
        label.textColor = UIColor.white
        label.font = UIFont.NunitoSansBold(size: 17)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    let text_Date: UILabel = {
        let label = UILabel()
        label.text = "11/06/20 11:11 PM"
        label.textColor = UIColor.white
        label.font = UIFont.NunitoSansRegular(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let image_QRCode: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "QR-Code")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    let btn_SavePNG: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.AccentColor
        button.layer.cornerRadius = 10
        button.setTitle("Save PNG", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.NunitoSansExtraBold(size: 17)
        button.setImage(#imageLiteral(resourceName: "Save"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.black
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 6
        button.addTarget(self, action: #selector(SavePNGButtonClicker), for: .touchUpInside)
        return button
    }()
    
    let btn_CopyNetworkName: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.AccentColor
        button.layer.cornerRadius = 10
        button.setTitle("SSID", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.NunitoSansExtraBold(size: 17)
        button.setImage(#imageLiteral(resourceName: "Content-Copy"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.black
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 6
        button.addTarget(self, action: #selector(CopyNetworkNameButtonClicker), for: .touchUpInside)
        return button
    }()
    
    let btn_CopyPassword: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.AccentColor
        button.layer.cornerRadius = 10
        button.setTitle("PASSWORD", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.NunitoSansExtraBold(size: 17)
        button.setImage(#imageLiteral(resourceName: "Content-Copy"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.black
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 6
        button.addTarget(self, action: #selector(CopyPasswordButtonClicker), for: .touchUpInside)
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
        
        SettingElement()
        
        SettingGoogleAdsBanner()
        
        SettingGoogleAdsinterstitial()

        Process()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        SettingGoogleAdsinterstitial()
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
        let rightBarButtonDelete = UIBarButtonItem(image: #imageLiteral(resourceName: "Bin"), style: .plain, target: self, action: #selector(DeleteButtonClicker))
        rightBarButtonDelete.imageInsets = UIEdgeInsets(top: -3, left: 35, bottom: 0, right: 0)
        rightBarButtonDelete.tintColor = .white
        
        let rightBarButtonShare = UIBarButtonItem(image: #imageLiteral(resourceName: "Share"), style: .plain, target: self, action: #selector(ShareButtonClicker))
        rightBarButtonShare.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: 0, right: -5)
        rightBarButtonShare.tintColor = .white

        navigationItem.rightBarButtonItems = [rightBarButtonShare,rightBarButtonDelete]
    }
    
    func SettingElement(){
        
        view.addSubview(view_QRCode)
        view_QRCode.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 25, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(view_Discription)
        view_Discription.anchor(view_QRCode.topAnchor, left: view_QRCode.leftAnchor, bottom: nil, right: view_QRCode.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(btn_Favorite)
        view.addSubview(btn_Edit)
        btn_Favorite.anchor(view_Discription.topAnchor, left: nil, bottom: nil, right: view_Discription.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 25, heightConstant: 25)
        btn_Edit.anchor(view_Discription.topAnchor, left: nil, bottom: nil, right: btn_Favorite.leftAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 25, heightConstant: 25)
        
        view.addSubview(text_Subject)
        view.addSubview(text_SSID)
        view.addSubview(text_Password)
        view.addSubview(text_Date)
        text_Subject.anchor(view_Discription.topAnchor, left: view_Discription.leftAnchor, bottom: nil, right: btn_Edit.leftAnchor, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        text_SSID.anchor(text_Subject.bottomAnchor, left: view_Discription.leftAnchor, bottom: nil, right: view_Discription.rightAnchor, topConstant: 15, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        text_Password.anchor(text_SSID.bottomAnchor, left: view_Discription.leftAnchor, bottom: nil, right: view_Discription.rightAnchor, topConstant: 5, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        text_Date.anchor(text_Password.bottomAnchor, left: view_Discription.leftAnchor, bottom: view_Discription.bottomAnchor, right: view_Discription.rightAnchor, topConstant: 5, leftConstant: 15, bottomConstant: 15, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(image_QRCode)
        image_QRCode.anchor(view_Discription.bottomAnchor, left: nil, bottom: view_QRCode.bottomAnchor, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 20, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        image_QRCode.anchorCenter(view_QRCode.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 150, heightConstant: 150)
        
        view.addSubview(btn_SavePNG)
        view.addSubview(btn_CopyNetworkName)
        view.addSubview(btn_CopyPassword)
        let btn_width = (view.frame.width - 50) / 2
            
        btn_SavePNG.anchor(view_QRCode.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 15, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 50)
        btn_CopyNetworkName.anchor(btn_SavePNG.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: btn_width, heightConstant: 50)
        btn_CopyPassword.anchor(btn_CopyNetworkName.topAnchor, left: btn_CopyNetworkName.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 20, widthConstant: btn_width, heightConstant: 50)
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
        
        view.layoutIfNeeded()
        view.addSubview(Google_Ads_banner)
        Google_Ads_banner.anchor(btn_CopyNetworkName.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 30, leftConstant: 20, bottomConstant: 10, rightConstant: 20, widthConstant: 0, heightConstant: 0)
    }
    
    func SettingGoogleAdsinterstitial(){
        
        let request_Save = GADRequest()
        GADInterstitialAd.load(withAdUnitID: String.GADInterstitial,
                               request: request_Save,
                               completionHandler: { [self] ad, error in
                                    if let error = error {
                                      print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                      return
                                    }
                                    Google_Ads_interstitial_Save = ad
                                    Google_Ads_interstitial_Save?.fullScreenContentDelegate = self
                               }
        )
        
        let request_Share = GADRequest()
        GADInterstitialAd.load(withAdUnitID: String.GADInterstitial,
                               request: request_Share,
                               completionHandler: { [self] ad, error in
                                    if let error = error {
                                      print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                      return
                                    }
                                    Google_Ads_interstitial_Share = ad
                                    Google_Ads_interstitial_Share?.fullScreenContentDelegate = self
                               }
        )
    }
    
    func Process(){
        //Remove button delete when come from page create
        if StateView == "Create"{
            
            text_SSID.text = "SSID : " + TextSSID
            text_Password.text = "Password : " + TextPass
                        
            //format WiFi creat text QRcode
            //WIFI:S:KASARONG_FM 5G;T:WPA;P:aannaa04;;
            
            TextCreateWiFi = "WIFI:S:" + TextSSID + ";T:" + encryption + ";P:" + TextPass + ";;"
            //TextCreateWiFi = "WIFI:T:" + encryption + ";S:" + TextSSID + ";P:" + TextPass + ";H:;"

            image_QRCode.image = generateQRCode(from: TextCreateWiFi)
            
            checkEncryption(Encryption: encryption)

            if TextSubject == ""{
                //insetr data to database history
                let ID = Int(NSDate().timeIntervalSince1970 * 100000)
                databaseHelper.insertData(subjectVal: "",
                                          typeVal: "WIFI",
                                          favoriteVal: FavoriteState,
                                          imageQrVal: (image_QRCode.image?.pngData())!,
                                          dateVal: Date,
                                          IDlistVal: String(ID),
                                          imageiconVal: imageicon.pngData()!,
                                          TextScaneVal: TextCreateWiFi,
                                          isCreate: true)
                
                IDlist = databaseHelper.getData().last!.IDlist
                TextSubjectFirst = databaseHelper.getData().last!.subject
                text_Subject.text = TextSubjectFirst
                text_Date.text = Date
            }else{
            
                //insetr data to database history
                let ID = Int(NSDate().timeIntervalSince1970 * 100000)
                databaseHelper.insertData(subjectVal: TextSubject,
                                          typeVal: "WIFI",
                                          favoriteVal: FavoriteState,
                                          imageQrVal: (image_QRCode.image?.pngData())!,
                                          dateVal: Date,
                                          IDlistVal: String(ID),
                                          imageiconVal: imageicon.pngData()!,
                                          TextScaneVal: TextCreateWiFi,
                                          isCreate: true)
                
                IDlist = databaseHelper.getData().last!.IDlist
                TextSubjectFirst = TextSubject
                text_Subject.text = TextSubject
                text_Date.text = Date

            }

        }else if StateView == "Scane" && navigationItem.rightBarButtonItems!.count > 1{
            navigationItem.rightBarButtonItems?.remove(at: 1)
            
            text_Subject.backgroundColor = UIColor.white
            text_Subject.textColor = UIColor.black
            text_Subject.isEnabled = true
            btn_Edit.setImage(#imageLiteral(resourceName: "Check"), for: .normal)
            EditSubjectState = true
            
            text_SSID.text = "SSID : " + TextSSID
            text_Password.text = "Password : " + TextPass

            image_QRCode.image = generateQRCode(from: TextCreateWiFi)

            //insetr data to database history
            let ID = Int(NSDate().timeIntervalSince1970 * 100000)
            databaseHelper.insertData(subjectVal: "",
                                      typeVal: "WIFI",
                                      favoriteVal: FavoriteState,
                                      imageQrVal: (image_QRCode.image?.pngData())!,
                                      dateVal: Date,
                                      IDlistVal: String(ID),
                                      imageiconVal: imageicon.pngData()!,
                                      TextScaneVal: TextCreateWiFi,
                                      isCreate: false)
            
            TextSubjectFirst = databaseHelper.getData().last!.subject
            IDlist = databaseHelper.getData().last!.IDlist
            text_Subject.text = TextSubjectFirst
            text_Date.text = Date
            
            checkEncryption(Encryption: encryption)

        }else if StateView == "History"{
            
            //Refromat WiFi
            let WiFi = refromatWiFi.init(fromat: TextCreateWiFi)
            
            text_Subject.text = TextSubject
            image_QRCode.image = imageQR
            text_SSID.text = "SSID : " + WiFi.SSID
            text_Password.text = "Password : " + WiFi.Pass
            TextSubjectFirst = TextSubject
            text_Date.text = Date

            if FavoriteState == "true"{
                btn_Favorite.setImage(#imageLiteral(resourceName: "Star_Full"), for: .normal)
            }else if FavoriteState == "false"{
                btn_Favorite.setImage(#imageLiteral(resourceName: "Star_Border"), for: .normal)
            }
            
            checkEncryption(Encryption: WiFi.Enc)
            
        }
        
    }
    
    func checkEncryption(Encryption:String){
        //remove text password when Encryption = nopass
        if Encryption == "nopass"{
            text_Password.removeFromSuperview()
            btn_CopyPassword.removeFromSuperview()
            view.layoutIfNeeded()
            text_Date.anchor(text_SSID.bottomAnchor, left: view_Discription.leftAnchor, bottom: view_Discription.bottomAnchor, right: view_Discription.rightAnchor, topConstant: 5, leftConstant: 15, bottomConstant: 15, rightConstant: 15, widthConstant: 0, heightConstant: 0)
            btn_CopyNetworkName.anchor(btn_SavePNG.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 50)
        }
    }
    
    @objc func BackButtonClicker(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func DeleteButtonClicker(){
        
        let alert = UIAlertController(title: "Delete", message: "do you want to delete this item?.", preferredStyle: UIAlertController.Style.alert)
        alert.setTitlet(font: UIFont.NunitoSansBold(size: 20), color: UIColor.systemRed)
        alert.setMessage(font: UIFont.NunitoSansRegular(size: 16), color: .black)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (acton) in
            self.databaseHelper.DeleteRow(ID: self.IDlist)
            
            if self.StateView == "Create"{
                self.navigationController?.popToRootViewController(animated: true)
            }else if self.StateView == "History"{
                self.navigationController?.popViewController(animated: true)
            }
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @objc func ShareButtonClicker(){

        guard let image = image_QRCode.image else {return}
        
        if Google_Ads_interstitial_Share != nil && PresentPage.StateRemoveAds == false{
            Google_Ads_interstitial_Share.present(fromRootViewController: self)
            presentAds_Share = true
        } else {
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    @objc func EditButtonClicker(){
        
        if EditSubjectState == false{//subject edit
            btn_Edit.setImage(#imageLiteral(resourceName: "Check"), for: .normal)
            text_Subject.backgroundColor = UIColor.white
            text_Subject.textColor = UIColor.black
            text_Subject.isEnabled = true
            EditSubjectState = true
            
            text_Subject.text = TextSubjectFirst
            
        }else{//subject confirm
        
            if text_Subject.text == ""{
                text_Subject.text = TextSubjectFirst
            }else if text_Subject.text != TextSubjectFirst{
                let SubjectUpdate = text_Subject.text
                //Subject not name Untitle
                let check = SubjectUpdate?.components(separatedBy: "Untitle")
                if check?.count == 1{
                    databaseHelper.EdittingSubjectRow(ID: IDlist, SubjectUpdate: SubjectUpdate!)
                    TextSubjectFirst = SubjectUpdate!
                }else{
                    Create_AlertMessage(Title: "amiss", TitleColor: UIColor.AccentColor!, Message: "Do not use the word Untitle.")
                    return
                }
            }
            
            btn_Edit.setImage(#imageLiteral(resourceName: "Edit"), for: .normal)
            text_Subject.backgroundColor = UIColor.clear
            text_Subject.textColor = UIColor.white
            text_Subject.isEnabled = false
            EditSubjectState = false
        }
        
    }
    
    @objc func FavoriteButtonClicker(){
        if FavoriteState == "false"{
            btn_Favorite.setImage(#imageLiteral(resourceName: "Star_Full"), for: .normal)
            FavoriteState = "true"
        }else{
            btn_Favorite.setImage(#imageLiteral(resourceName: "Star_Border"), for: .normal)
            FavoriteState = "false"
        }
        databaseHelper.EdittingFavoriteRow(ID: IDlist, FavoriteUpdate: FavoriteState)
    }
    
    @objc func SavePNGButtonClicker(){
        if Google_Ads_interstitial_Save != nil && PresentPage.StateRemoveAds == false{
            Google_Ads_interstitial_Save.present(fromRootViewController: self)
            presentAds_Save = true
        } else {
           SavePoto(imageQRcode:image_QRCode)
        }
    }
    
    @objc func CopyNetworkNameButtonClicker(){
        UIPasteboard.general.string = TextSSID
        Create_AlertMessage(Title: "Copy SSID", TitleColor: .black, Message: "")
    }
    
    @objc func CopyPasswordButtonClicker(){
        UIPasteboard.general.string = TextPass
        Create_AlertMessage(Title: "Copy password", TitleColor: .black, Message: "")
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

extension DetailWifiController : GADBannerViewDelegate{
    
    // Tells the delegate an ad request loaded an ad.
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        
        view.addSubview(btn_CloseAds)
        btn_CloseAds.anchor(Google_Ads_banner.topAnchor, left: nil, bottom: nil, right: Google_Ads_banner.rightAnchor, topConstant: -25, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
    }
    
}

extension DetailWifiController : GADFullScreenContentDelegate{
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        if presentAds_Save {
            SavePoto(imageQRcode:image_QRCode)
            presentAds_Save = false
        }else if presentAds_Share {
            presentAds_Share = false
            DispatchQueue.main.async {
                guard let image = self.image_QRCode.image else {return}
                let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view

                // present the view controller
                self.present(activityViewController, animated: true, completion: nil)
            }

        }
    }
    
}
