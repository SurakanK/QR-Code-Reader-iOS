//
//  CreateController.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 6/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CreateController: UIViewController {
    
    //Data Create Preview
    let DataTitle = ["Website","WiFi","Text"]
    let DataLogo = [#imageLiteral(resourceName: "Website-1").withTintColor(UIColor.PrimaryColor!),
                    #imageLiteral(resourceName: "WiFi").withTintColor(UIColor.PrimaryColor!),
                    #imageLiteral(resourceName: "EditHistory").withTintColor(UIColor.PrimaryColor!)]
    
    var CellID = "Cell"
    weak var CollectionView_Create : UICollectionView?
    
    var Google_Ads_banner: GADBannerView!
    var databaseHelper: SQLiteHelper = SQLiteHelper.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.SecondaryColor
        
        SettingElement()
        SettingGoogleAdsBanner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //remove ads when payment
        if PresentPage.StateRemoveAds == false{
            Google_Ads_banner.load(GADRequest())
        }else{
            Google_Ads_banner.removeFromSuperview()
        }

    }
    
    func checkCreateItemIndex() -> Int{
        let DataHistory = databaseHelper.getData()
        let filter = DataHistory.filter{$0.Create == true}
        return filter.count
    }
    
    func SettingElement(){
        
        //ConfigRegister CollectionView Create
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        CollectionView_Create = collection
        CollectionView_Create!.register(CreateCell.self, forCellWithReuseIdentifier: CellID)
        CollectionView_Create!.backgroundColor = .systemGray6
        CollectionView_Create!.delegate = self
        CollectionView_Create!.dataSource = self
        CollectionView_Create!.showsHorizontalScrollIndicator = false
        CollectionView_Create!.backgroundColor = .clear
        
        //set layout CollectionView Create
        view.addSubview(CollectionView_Create!)
        CollectionView_Create!.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func SettingGoogleAdsBanner(){
           
        Google_Ads_banner = GADBannerView(adSize: kGADAdSizeBanner)
        Google_Ads_banner.backgroundColor = .clear
        
        Google_Ads_banner.adUnitID = String.GADBannerID
        Google_Ads_banner.rootViewController = self
       
        //remove ads when payment
        if PresentPage.StateRemoveAds == false{
            Google_Ads_banner.load(GADRequest())
        }
        
        view.addSubview(Google_Ads_banner)
        Google_Ads_banner.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
    }
}

// MARK: CollectionView Preview
extension CreateController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = CollectionView_Create!.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! CreateCell
    
        //present data in cell
        cell.Title_Create.text = DataTitle[indexPath.row]
        cell.image_Logo.image = DataLogo[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
               
        if PresentPage.StateRemoveAds {
            //Select Menu
            switch indexPath.row {
            case 0:// create QRcode web
                let viewPresent = CreateWebSiteController()
                self.navigationController?.pushViewController(viewPresent, animated: true)
            case 1:// create QRcode Wifi
                let viewPresent = CreateWiFiController()
                self.navigationController?.pushViewController(viewPresent, animated: true)
            case 2:// create QRcode Text
                let viewPresent = CreateTextController()
                self.navigationController?.pushViewController(viewPresent, animated: true)
            default:break
            }
        } else {
            if (checkCreateItemIndex() < 5) {
                //Select Menu
                switch indexPath.row {
                case 0:// create QRcode web
                    let viewPresent = CreateWebSiteController()
                    self.navigationController?.pushViewController(viewPresent, animated: true)
                case 1:// create QRcode Wifi
                    let viewPresent = CreateWiFiController()
                    self.navigationController?.pushViewController(viewPresent, animated: true)
                case 2:// create QRcode Text
                    let viewPresent = CreateTextController()
                    self.navigationController?.pushViewController(viewPresent, animated: true)
                default:break
                }
            } else {
                DispatchQueue.main.async { // Correct
                    self.Create_AlertMessage(Title: "You Can't Create", TitleColor: .black, Message: "you can't create QR code. you have the maximum qr code create \n5 to 5")
                }
            }
        }
    }
    
    //set size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 50) / 2
        let height = width * 1.18
        
        return CGSize(width: width, height: height)
    }
    
    //set space between cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    //set space between cell and viewcontroller
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    

}
