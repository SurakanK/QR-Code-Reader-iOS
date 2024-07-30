//
//  PresentPage.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 6/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//

import UIKit
import Alamofire
import AppTrackingTransparency
import AdSupport

class PresentPage: UIViewController {
    
    static var StateRemoveAds = true
    
    let view_main: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.alpha = 0
        return view
    }()

    var Image_background : UIImageView = {
        let image = UIImageView(frame: UIScreen.main.bounds)
        image.image = #imageLiteral(resourceName: "mitya-ivanov-2HWkORIX3II-unsplash")
        image.alpha = 0.05
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()

    var Image_Logo : UIImageView = {
        let image = UIImageView(frame: UIScreen.main.bounds)
        image.image = #imageLiteral(resourceName: "Logo-QR-Code-Reader-in-app").withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFill
        /*image.layer.shadowOffset = CGSize(width: 3, height: 3)
        image.layer.shadowRadius = 2
        image.layer.shadowOpacity = 6
        image.layer.masksToBounds = true*/
        return image
    }()

    let title_Name: UILabel = {
        let label = UILabel()
        label.text = "QR Code Reader Online"
        label.textColor = UIColor.white
        label.font = UIFont.NunitoSansBlack(size: 30)
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.shadowRadius = 2
        label.layer.shadowOpacity = 6
        label.numberOfLines = 0
        return label
    }()

    let view_center: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.PrimaryColor

        setting_Element()
        requestIDFA()
        
        view_main.translatesAutoresizingMaskIntoConstraints = false
         
         UIView.animate(withDuration: 1) {
            self.view_main.alpha = 1
         }
        
         //UIView.animate(withDuration: 1, delay: 2, options: .curveLinear, animations: {

         UIView.animate(withDuration: 1, delay: 2, options: .curveLinear, animations: {
            self.view_main.alpha = 0
         }) { (Sucess : Bool) in
             if Sucess == true{
                 
                
                // Check User Payment for Remove Ads ?
                if UserDefaults.standard.bool(forKey: "Preview"){
                    
                    let viewPresent = TabbarMainController()
                    let navigation = UINavigationController(rootViewController: viewPresent)
                    navigation.isNavigationBarHidden = true
                    navigation.modalPresentationStyle = .fullScreen
                    self.present(navigation, animated: true, completion: nil)
                    
                }else {
                    let viewPresent = PreviewPageController()
                    let navigation = UINavigationController(rootViewController: viewPresent)
                    navigation.isNavigationBarHidden = true
                    navigation.modalPresentationStyle = .fullScreen
                    self.present(navigation, animated: true, completion: nil)
                }
                
             }
        }
        
    }
    
    func requestIDFA() {
      ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
        // Tracking authorization completed. Start loading ads here.
        PresentPage.StateRemoveAds = false
      })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        // Check User Payment for Remove Ads ?
        if UserDefaults.standard.bool(forKey: "QRF_099_1month"){
            PresentPage.StateRemoveAds = true
        }
//        checkReceiptsPayment()
    }
    
    func checkReceiptsPayment(){
        // Get the receipt if it's available
        if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
            FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {

            do {
                let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
                let receiptString = receiptData.base64EncodedString(options: [])
                
                let password = "4a998acd1f074bec866ab847eef2964d"
                let Header : HTTPHeaders = [.contentType("application/json")]

                #if DEBUG
                    let Url = "https://sandbox.itunes.apple.com/verifyReceipt"
                #else
                    let Url = "https://buy.itunes.apple.com/verifyReceipt"
                #endif
                
                let parameters = ["receipt-data":receiptString,"password":password, "exclude-old-transactions": true] as [String : Any]
                AF.request(Url, method: .post,parameters: parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
                    
                    switch response.result{
                    case .success(let value):
                        
                        //get data Receipts ExpiresDate
                        let JSON = value as? [String : Any]
                        let latest_receipt_info = JSON!["latest_receipt_info"] as? [[String : Any]]
                        let expires_date = latest_receipt_info?.last!["expires_date"] as? String
                        let ExpiresDate = expires_date!.components(separatedBy: " Etc/GMT").first

                        //get PresentDate
                        let date = Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "YYY-MM-dd HH:mm:ss"
                        formatter.timeZone = TimeZone(abbreviation: "UTC")
                        let PresentDate = formatter.string(from: date)

//                        print(ExpiresDate,PresentDate)

                        //check Expires Date
                        if ExpiresDate?.compare(PresentDate) == .orderedDescending {
                            UserDefaults.standard.set(true, forKey: "QRF_099_1month")
                            PresentPage.StateRemoveAds = true
                        }else{
                            UserDefaults.standard.set(false, forKey: "QRF_099_1month")
                            PresentPage.StateRemoveAds = false
                        }

                    case .failure(_):
                
                    break
                    }
                })
                
                //print(receiptString)
                // Read receiptData
            }
            catch {
                print("Couldn't read receipt data with error: " + error.localizedDescription)
                
            }
        }
    }
    
    func setting_Element(){
        
        view.addSubview(view_main)
        view_main.addSubview(Image_background)
        view_main.addSubview(view_center)
        view_center.addSubview(Image_Logo)
        view_center.addSubview(title_Name)
        
        //set element background app--------------------------------
        Image_background.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //set element logo and name app--------------------------------
        view_center.anchorCenter(view.centerXAnchor, AxisY: view.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: -50, widthConstant: 0, heightConstant: 0)
        
        title_Name.anchor(view_center.topAnchor, left: view_center.leftAnchor, bottom: nil, right: view_center.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Image_Logo.anchorCenter(view_center.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Image_Logo.anchor(title_Name.bottomAnchor, left: nil, bottom: view_center.bottomAnchor, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 200, heightConstant: 200)
        
        
    }
}
