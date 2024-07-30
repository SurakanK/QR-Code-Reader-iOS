//
//  PreviewPageController.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 3/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//

import UIKit

class PreviewPageController: UIViewController {
    
    weak var collectionView_Preview : UICollectionView?
    
    //Data present Preview
    let DataTitle = ["Scaner","History","Create QR"]
    let DataLogo = [#imageLiteral(resourceName: "Preview_Scan"),#imageLiteral(resourceName: "Preview_HistoryScan"),#imageLiteral(resourceName: "Preview_CreateQR")]
    let DataDiscription = ["This application can scan QR Code and Barcode.",
                           "This application will store the scan history in the application.",
                           "This application can scan QR Code and Barcode."]
    
    let Btn_Skip: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.AccentColor
        button.layer.cornerRadius = 10
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.NunitoSansExtraBold(size: 17)
        button.addTarget(self, action: #selector(SkipButtonClicker), for: .touchUpInside)
        button.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0
        return button
    }()
    
    let Btn_PrivacyPolicy: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.NunitoSansExtraBold(size: 17)
        button.addTarget(self, action: #selector(PrivacyButtonClicker), for: .touchUpInside)
        return button
    }()
    
    let Btn_Terms: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.setTitle("Terms", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.NunitoSansExtraBold(size: 17)
        button.addTarget(self, action: #selector(TermsButtonClicker), for: .touchUpInside)
        return button
    }()
    
    let view_Container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.tintColor = .whiteAlpha(alpha: 0.2)
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        pageControl.isEnabled = false
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        SettingElement()
    }
    
    //change animation page Control when move page
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = view.frame.width
        pageControl.currentPage = Int((collectionView_Preview!.contentOffset.x) / pageWidth)
    }
    
    func SettingElement(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView_Preview = collection
        collectionView_Preview!.register(PreviewPageCell.self, forCellWithReuseIdentifier: "CellPreview")
        collectionView_Preview!.backgroundColor = .systemGray6
        collectionView_Preview!.delegate = self
        collectionView_Preview!.dataSource = self
        collectionView_Preview!.showsHorizontalScrollIndicator = false
        collectionView_Preview!.backgroundColor = UIColor.PrimaryColor
        
        //move lock collectionview to page
        collectionView_Preview?.isPagingEnabled = true
        
        view.addSubview(collectionView_Preview!)
        collectionView_Preview!.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(Btn_Skip)
        Btn_Skip.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 20, rightConstant: 20, widthConstant: 0, heightConstant: 60)

        view.addSubview(view_Container)
        view_Container.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        view_Container.anchor(nil, left: nil, bottom: Btn_Skip.topAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        view_Container.addSubview(Btn_PrivacyPolicy)
        Btn_PrivacyPolicy.anchor(view_Container.topAnchor, left: view_Container.leftAnchor, bottom: view_Container.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view_Container.addSubview(Btn_Terms)
        Btn_Terms.anchor(view_Container.topAnchor, left:Btn_PrivacyPolicy.rightAnchor, bottom: view_Container.bottomAnchor, right: view_Container.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(pageControl)
        pageControl.anchor(nil, left: view.leftAnchor, bottom: view_Container.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 50, bottomConstant: 20, rightConstant: 50, widthConstant: 0, heightConstant: 0)
        
        //number of page Control
        pageControl.numberOfPages = DataTitle.count
    }
    
    @objc func SkipButtonClicker(){
        
        if UserDefaults.standard.bool(forKey: "Preview"){
           self.dismiss(animated: true, completion: nil)
        }else {
            let viewPresent = TabbarMainController()
            let navigation = UINavigationController(rootViewController: viewPresent)
            navigation.isNavigationBarHidden = true
            navigation.modalPresentationStyle = .fullScreen
            self.present(navigation, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "Preview")
        }
    }
    
    @objc func PrivacyButtonClicker(){
        let viewPresent = PrivacyTermsController()
        viewPresent.state = "Privacy"
        viewPresent.modalPresentationStyle = .formSheet
        self.present(viewPresent, animated: true, completion: nil)
    }
    
    @objc func TermsButtonClicker(){
        let viewPresent = PrivacyTermsController()
        viewPresent.state = "Terms"
        viewPresent.modalPresentationStyle = .formSheet
        self.present(viewPresent, animated: true, completion: nil)
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

// MARK: CollectionView Preview
extension PreviewPageController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView_Preview!.dequeueReusableCell(withReuseIdentifier: "CellPreview", for: indexPath) as! PreviewPageCell
        
        //present data preview
        cell.Title_Header.text = DataTitle[indexPath.row]
        cell.imageLogo.image = DataLogo[indexPath.row]
        cell.Text_Discription.text = DataDiscription[indexPath.row]
    
        return cell

    }
    
    //set size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    //set space between cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}


