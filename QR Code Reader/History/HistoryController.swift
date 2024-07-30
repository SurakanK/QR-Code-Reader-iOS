//
//  HistoryController.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 6/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//

import UIKit
import UIDropDown
import GoogleMobileAds

class HistoryController: UIViewController {
    
    var CellID = "Cell"
    weak var tableView_History : UITableView?

    //SQlite database
    var databaseHelper: SQLiteHelper = SQLiteHelper.init()
    var DataHistory = [Person]()
    var DataHistoryFilter = [Person]()
    
    var filterFav = ""
    var filterType = ""
    
    var Google_Ads_banner: GADBannerView!

    let viewHeader: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 6
        return view
    }()
    
    let Title_Filter: UILabel = {
        let label = UILabel()
        label.text = "Filter"
        label.textColor = UIColor.PrimaryColor
        label.font = UIFont.NunitoSansBold(size: 17)
        label.numberOfLines = 0
        return label
    }()
    
    let DropDownFilter1: UIDropDown = {
        let DropDownSort = UIDropDown(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        let DataSort = ["All","Favorite"]
        DropDownSort.options = DataSort
        DropDownSort.optionsFont = "NunitoSans-Regular"
        DropDownSort.optionsSize = 17
        DropDownSort.optionsTextAlignment = .center
        DropDownSort.hideOptionsWhenSelect = true
        DropDownSort.rowHeight = 40
        DropDownSort.tableHeight = 40 * CGFloat(DataSort.count)
        DropDownSort.borderWidth = 0
        DropDownSort.arrowPadding = 0.5
        DropDownSort.addTarget(self, action: #selector(touch_DropDownFilter1), for: .touchUpInside)
        return DropDownSort
    }()
    
    let Title_DropDownFilter1: UILabel = {
        let label = UILabel()
        label.text = "All"
        label.textColor = UIColor(hex: "#707070FF")
        label.font = UIFont.NunitoSansRegular(size: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let DropDownFilter2: UIDropDown = {
        let DropDownSort = UIDropDown(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        let DataSort = ["All Type","WiFi","Website","Text","Barcode"]
        DropDownSort.options = DataSort
        DropDownSort.optionsFont = "NunitoSans-Regular"
        DropDownSort.optionsSize = 17
        DropDownSort.optionsTextAlignment = .center
        DropDownSort.hideOptionsWhenSelect = true
        DropDownSort.rowHeight = 40
        DropDownSort.tableHeight = 40 * CGFloat(DataSort.count)
        DropDownSort.borderWidth = 0
        DropDownSort.arrowPadding = 0.5
        DropDownSort.addTarget(self, action: #selector(touch_DropDownFilter2), for: .touchUpInside)
        return DropDownSort
    }()
    
    let Title_DropDownFilter2: UILabel = {
        let label = UILabel()
        label.text = "All Type"
        label.textColor = UIColor(hex: "#707070FF")
        label.font = UIFont.NunitoSansRegular(size: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.SecondaryColor
        self.navigationController?.isNavigationBarHidden = true
        
        //Set NotificationCenter when insert Data
        NotificationCenter.default.addObserver(self, selector: #selector(RefilterHistory(notification:)), name: NSNotification.Name(rawValue: "RefilterHistory"), object: nil)
        
        SettingElement()
        DropDownEvent()

        SettingGoogleAdsBanner()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(true, animated: true)

        //get data History list from SQlite
        DataHistory = databaseHelper.getData()
        
        DataHistoryFilter(filterFav: filterFav, filterType: filterType)
                
        //remove ads when payment
        if PresentPage.StateRemoveAds == false{
            Google_Ads_banner.load(GADRequest())
        }else{
            Google_Ads_banner.removeFromSuperview()
        }

    }
    
    func DataHistoryFilter(filterFav:String, filterType:String){
        
        DataHistoryFilter.removeAll()
        
        var DataHistoryFilterFav = [Person]()
        
        //filter FilterFaveride History
        if !filterFav.isEmpty{
            DataHistoryFilterFav = DataHistory.filter{$0.favorite == filterFav}
        }else{
            DataHistoryFilterFav = DataHistory
        }
        
        //filter type History
        if !filterType.isEmpty{
            DataHistoryFilter = DataHistoryFilterFav.filter{$0.type == filterType}
        }else{
            DataHistoryFilter = DataHistoryFilterFav
        }
        
        tableView_History?.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        DropDownFilter1.dismissTable = true
        DropDownFilter2.dismissTable = true
    }
    
    func SettingElement(){
        
        view.addSubview(viewHeader)
        viewHeader.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        viewHeader.addSubview(Title_Filter)
        Title_Filter.anchor(view.safeAreaLayoutGuide.topAnchor, left: viewHeader.leftAnchor, bottom: viewHeader.bottomAnchor, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //ConfigRegister tableView History
        let table =  UITableView(frame: .zero)
        tableView_History = table
        tableView_History!.rowHeight = UITableView.automaticDimension
        tableView_History!.backgroundColor = .white
        tableView_History!.register(HistoryCell.self, forCellReuseIdentifier: CellID)
        tableView_History!.separatorStyle = .none
        tableView_History!.delegate = self
        tableView_History!.dataSource = self
        tableView_History!.backgroundColor = .clear
        
        //set layout tableView History
        view.addSubview(tableView_History!)
        tableView_History!.anchor(viewHeader.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(DropDownFilter1)
        view.addSubview(Title_DropDownFilter1)
        DropDownFilter1.anchor(Title_Filter.topAnchor, left: Title_Filter.rightAnchor, bottom: Title_Filter.bottomAnchor, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: DropDownFilter1.frame.width, heightConstant: 0)
        Title_DropDownFilter1.anchor(Title_Filter.topAnchor, left: Title_Filter.rightAnchor, bottom: Title_Filter.bottomAnchor, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: DropDownFilter1.frame.width, heightConstant: 0)
        
        view.addSubview(DropDownFilter2)
        view.addSubview(Title_DropDownFilter2)
        DropDownFilter2.anchor(Title_Filter.topAnchor, left: DropDownFilter1.rightAnchor, bottom: Title_Filter.bottomAnchor, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: DropDownFilter1.frame.width, heightConstant: 0)
        Title_DropDownFilter2.anchor(Title_Filter.topAnchor, left: DropDownFilter1.rightAnchor, bottom: Title_Filter.bottomAnchor, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: DropDownFilter1.frame.width, heightConstant: 0)
        
    }
    
    func SettingGoogleAdsBanner(){
        
        Google_Ads_banner = GADBannerView(adSize: kGADAdSizeBanner)
        Google_Ads_banner.backgroundColor = .clear
        
        Google_Ads_banner.adUnitID = String.GADBannerID
        Google_Ads_banner.rootViewController = self
        Google_Ads_banner.delegate = self
        
        //remove ads when payment
        if PresentPage.StateRemoveAds == false{
            Google_Ads_banner.load(GADRequest())
        }
        
        view.addSubview(Google_Ads_banner)
        Google_Ads_banner.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
    }
    
    func DropDownEvent(){
        DropDownFilter1.didSelect { (Text, index) in
            self.Title_DropDownFilter1.text = Text
            self.DropDownFilter1.placeholder = ""
            
            switch index {
            case 0: self.filterFav = ""
            case 1: self.filterFav = "true"
            default:break
            }

            self.DataHistoryFilter(filterFav: self.filterFav, filterType: self.filterType)
        }
        
        DropDownFilter2.didSelect { (Text, index) in
            self.Title_DropDownFilter2.text = Text
            self.DropDownFilter2.placeholder = ""
            
            switch index {
            case 0: self.filterType = ""
            case 1: self.filterType = "WIFI"
            case 2: self.filterType = "WEB"
            case 3: self.filterType = "TEXT"
            case 4: self.filterType = "Barcode"
            default:break
            }
            
            self.DataHistoryFilter(filterFav: self.filterFav, filterType: self.filterType)

        }
        
    }
    
    @objc func RefilterHistory(notification: NSNotification) {
        filterFav = ""
        filterType = ""
        Title_DropDownFilter1.text = "All"
        Title_DropDownFilter2.text = "All Type"
    }
    
    @objc func touch_DropDownFilter1(){
        DropDownFilter2.dismissTable = true
    }
    
    @objc func touch_DropDownFilter2(){
        DropDownFilter1.dismissTable = true
    }
    
}

extension HistoryController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataHistoryFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! HistoryCell
        
        let imageicon = UIImage(data: DataHistoryFilter[indexPath.row].imageicon)
        
        //present image Logo
        cell.imageLogo.image = imageicon?.withTintColor(UIColor.PrimaryColor!)
        
        //present subject name
        cell.Title_name.text = DataHistoryFilter[indexPath.row].subject
        
        //present favorite State
        let favoriteState = DataHistoryFilter[indexPath.row].favorite
        if favoriteState == "true"{
            cell.imagefavourite.image = #imageLiteral(resourceName: "Star_Full").withTintColor(UIColor.AccentColor!)
        }else if favoriteState == "false"{
            cell.imagefavourite.image = #imageLiteral(resourceName: "Star_Border").withTintColor(UIColor.AccentColor!)
        }

        //present date
        cell.text_date.text = DataHistoryFilter[indexPath.row].Date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           
        let delete = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
                        
            
            let alert = UIAlertController(title: "Delete", message: "do you want to delete this item?.", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (acton) in
                let id = self.DataHistoryFilter[indexPath.row].IDlist
                self.databaseHelper.DeleteRow(ID: id)
                self.tableView_History!.setEditing(false, animated: true)
                self.DataHistoryFilter.remove(at: indexPath.row)
                self.tableView_History!.deleteRows(at: [indexPath], with: .automatic)

            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            completionHandler(true)
        }
           
           
        delete.backgroundColor = UIColor.SecondaryColor
        delete.image = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40)).image { _ in
            #imageLiteral(resourceName: "Bin").withTintColor(UIColor(hex: "#FF1A1AFF")!).draw(in: CGRect(x: 0, y: 0, width: 35, height: 35))}
                           
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        
        return configuration
           
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //navController.hidesBottomBarWhenPushed = true
        tabBarController?.hidesBottomBarWhenPushed = true
        
        let id = DataHistoryFilter[indexPath.row].IDlist
        let type = DataHistoryFilter[indexPath.row].type
        let Date = DataHistoryFilter[indexPath.row].Date
        let Textscan = DataHistoryFilter[indexPath.row].TextScane
        let TextSubjct = DataHistoryFilter[indexPath.row].subject
        let favoriteState = DataHistoryFilter[indexPath.row].favorite
        let imageQr = UIImage(data: DataHistoryFilter[indexPath.row].imageQr)
        
        switch type {
        case "WEB":
            let viewPresent = DetailWebController()
            viewPresent.StateView = "History"
            viewPresent.IDlist = id
            viewPresent.TextUrl = Textscan
            viewPresent.TextSubject = TextSubjct
            viewPresent.imageQR = imageQr!
            viewPresent.FavoriteState = favoriteState
            viewPresent.Date = Date            
            navigationController?.pushViewController(viewPresent, animated: true)
            
        case "WIFI":
            let viewPresent = DetailWifiController()
            viewPresent.StateView = "History"
            viewPresent.IDlist = id
            viewPresent.TextCreateWiFi = Textscan
            viewPresent.TextSubject = TextSubjct
            viewPresent.imageQR = imageQr!
            viewPresent.FavoriteState = favoriteState
            viewPresent.Date = Date
            navigationController?.pushViewController(viewPresent, animated: true)
       
        case "TEXT":
            let viewPresent = DetailTextController()
            viewPresent.StateView = "History"
            viewPresent.IDlist = id
            viewPresent.TextView = Textscan
            viewPresent.TextSubject = TextSubjct
            viewPresent.imageQR = imageQr!
            viewPresent.FavoriteState = favoriteState
            viewPresent.Date = Date
            navigationController?.pushViewController(viewPresent, animated: true)

        case "Barcode":
            let viewPresent = DetailBarcodeController()
            viewPresent.StateView = "History"
            viewPresent.IDlist = id
            viewPresent.TextBarcode = Textscan
            viewPresent.TextSubject = TextSubjct
            viewPresent.imageBarcode = imageQr!
            viewPresent.FavoriteState = favoriteState
            viewPresent.Date = Date
            navigationController?.pushViewController(viewPresent, animated: true)
            
        default:break
        }

    }
    

}

extension HistoryController : GADBannerViewDelegate{
    
    // Tells the delegate an ad request loaded an ad.
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
       
        tableView_History!.anchor(viewHeader.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 50, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
}
