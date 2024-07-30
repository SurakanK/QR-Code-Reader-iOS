//
//  UpgradeController.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 6/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//

import UIKit
import StoreKit
import Alamofire

class UpgradeController: UIViewController {
    
    // Parameter for Payment
    var myProduct: SKProduct?
    
    var StateView = "Tabbar"
    
    let viewShadow: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 6
        return view
    }()
    
    let Title_Pro_Version: UILabel = {
        let label = UILabel()
        label.text = "Pro Version"
        label.textColor = UIColor.PrimaryColor
        label.font = UIFont.NunitoSansBlack(size: 26)
        label.numberOfLines = 0
        return label
    }()
    
    let Title_Remove: UILabel = {
        let label = UILabel()
        label.text = "Remove Ads"
        label.textColor = UIColor.PrimaryColor
        label.font = UIFont.NunitoSansBlack(size: 22)
        label.numberOfLines = 0
        return label
    }()
    
    let image_Remove: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "remove").withTintColor(UIColor.PrimaryColor!)
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    let text_Remove: UILabel = {
        let label = UILabel()
        label.text = "No more ads! Enjoy the full scanning experience."
        label.textColor = UIColor.gray
        label.font = UIFont.NunitoSansRegular(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let image_Unlimited: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Unlimit").withTintColor(UIColor.PrimaryColor!)
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    let Title_Unlimited: UILabel = {
        let label = UILabel()
        label.text = "Unlimited Create QR Code"
        label.textColor = UIColor.PrimaryColor
        label.font = UIFont.NunitoSansBlack(size: 22)
        label.numberOfLines = 0
        return label
    }()
    
    let text_Unlimited: UILabel = {
        let label = UILabel()
        label.text = "You will be able to create Unlimited number of QR codes."
        label.textColor = UIColor.gray
        label.font = UIFont.NunitoSansRegular(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let Title_Price: UILabel = {
        let label = UILabel()
        label.text = "Subscription"
        label.textColor = UIColor.PrimaryColor
        label.font = UIFont.NunitoSansBlack(size: 26)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let btn_Payment: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.AccentColor
        button.layer.cornerRadius = 10
        button.setTitle("$0.99 / Month", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.NunitoSansExtraBold(size: 17)
        button.addTarget(self, action: #selector(ButtonPaymentClicker), for: .touchUpInside)
        button.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 6
        return button
    }()
    
    let btn_Restore: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 10
        button.setTitle("Restore Subscription", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.NunitoSansExtraBold(size: 17)
        button.addTarget(self, action: #selector(ButtonRestoreClicker), for: .touchUpInside)
        button.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 6
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.SecondaryColor

        if StateView == "Tabbar"{
            self.navigationController?.isNavigationBarHidden = true
        }else if StateView == "CloseAds"{
            //set navigation Controller
            navigationItem.title = "Upgrade"
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.navigationBar.barTintColor = UIColor.PrimaryColor
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.NunitoSansBlack(size: 26)]
              
            //set navigationItem leftBarButton
            let leftBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow"), style: .plain, target: self, action: #selector(BackButtonClicker))
            leftBarButton.imageInsets = UIEdgeInsets(top: -3, left: -5, bottom: 0, right: 0)
            navigationItem.leftBarButtonItem = leftBarButton
            navigationItem.leftBarButtonItem?.tintColor = .white
        }

        SettingElement()
        
        // Config Payment Request for Remove Ads of User
        fetchProduct()
        setTextSubscription()
        
        SKPaymentQueue.default().add(self)

    }
    
    // Func Fetch Product (Payment remove Ads)
    func fetchProduct() {
        
        let request = SKProductsRequest(productIdentifiers: ["QRF_099_1month"])
        request.delegate = self
        request.start()

    }
    
    func SettingElement(){
        
        view.addSubview(viewShadow)
        viewShadow.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        viewShadow.addSubview(Title_Pro_Version)
        Title_Pro_Version.anchor(viewShadow.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 25, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        Title_Pro_Version.anchorCenter(viewShadow.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        viewShadow.addSubview(image_Remove)
        viewShadow.addSubview(Title_Remove)
        viewShadow.addSubview(text_Remove)
        image_Remove.anchor(Title_Pro_Version.bottomAnchor, left: viewShadow.leftAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 25, heightConstant: 25)
        Title_Remove.anchor(image_Remove.topAnchor, left: image_Remove.rightAnchor, bottom: nil, right: viewShadow.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        text_Remove.anchor(Title_Remove.bottomAnchor, left: image_Remove.rightAnchor, bottom: nil, right: viewShadow.rightAnchor, topConstant: 5, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        viewShadow.addSubview(image_Unlimited)
        viewShadow.addSubview(Title_Unlimited)
        viewShadow.addSubview(text_Unlimited)
        image_Unlimited.anchor(text_Remove.bottomAnchor, left: viewShadow.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 25, heightConstant: 25)
        Title_Unlimited.anchor(image_Unlimited.topAnchor, left: image_Unlimited.rightAnchor, bottom: nil, right: viewShadow.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        text_Unlimited.anchor(Title_Unlimited.bottomAnchor, left: image_Unlimited.rightAnchor, bottom: viewShadow.bottomAnchor, right: viewShadow.rightAnchor, topConstant: 5, leftConstant: 15, bottomConstant: 20, rightConstant: 15, widthConstant: 0, heightConstant: 0)

        view.addSubview(Title_Price)
        Title_Price.anchorCenter(viewShadow.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Title_Price.anchor(viewShadow.bottomAnchor, left: viewShadow.leftAnchor, bottom: nil, right: viewShadow.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(btn_Payment)
        btn_Payment.anchor(Title_Price.bottomAnchor, left: viewShadow.leftAnchor, bottom: nil, right: viewShadow.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        view.addSubview(btn_Restore)
        btn_Restore.anchor(btn_Payment.bottomAnchor, left: viewShadow.leftAnchor, bottom: nil, right: viewShadow.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
    }
    
    @objc func BackButtonClicker(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func ButtonPaymentClicker(){
        
       guard let myProduct = myProduct else{return}
       
       if SKPaymentQueue.canMakePayments(){
           let payment = SKPayment(product: myProduct)
           SKPaymentQueue.default().add(payment)
       }
    }
    
    @objc func ButtonRestoreClicker(){
        if (SKPaymentQueue.canMakePayments()) {
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        self.Create_AlertMessage(Title: "subscription", TitleColor: .black, Message: "restore success.")
    }

    func paymentQueue(_ queue: SKPaymentQueue,restoreCompletedTransactionsFailedWithError error: Error) {
    
    }
    
    func setTextSubscription(){
        if (PresentPage.StateRemoveAds) {
            Title_Price.text = "subscription success"
            btn_Payment.isHidden = true
            btn_Restore.isHidden = true
        } else {
            Title_Price.text = "Subscription"
            btn_Payment.isHidden = false
            btn_Restore.isHidden = false
        }
    }
}

// extension Payment Request
extension UpgradeController : SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        if let product = response.products.first {
            myProduct = product
        }
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            switch transaction.transactionState {
            
            case .purchasing:
                // no op
                print("purchasing")
                break
                
            case .purchased, .restored:
                // unlock their item
                UserDefaults.standard.set(true, forKey: "QRF_099_1month")
                // Change State Remove Ads
                PresentPage.StateRemoveAds = true
                setTextSubscription()
                print("Success")
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                break
                
            case .failed:
                print("failed")
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                break
                
            default:
                print("default")
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                break
            }
        }
        
    }
        
}
