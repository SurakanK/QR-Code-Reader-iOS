//
//  TabbarMainController.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 6/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//

import UIKit

class TabbarMainController: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        tabBar.tintColor = UIColor.AccentColor
        tabBar.unselectedItemTintColor = .white
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.PrimaryColor
        
        //Set Font and size of tabBar
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.NunitoSansBold(size: 13)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.NunitoSansBold(size: 13)], for: .selected)
        
        
        //Set viewcontroller in tabbar
        let Scanner = tabBarNavigation(UnSelectImage: #imageLiteral(resourceName: "Scan"),
                                       SelectImage: #imageLiteral(resourceName: "Scan"),
                                       title: "Scan",
                                       rootViewController: ScannerPageController())
        
        let Create = tabBarNavigation(UnSelectImage: #imageLiteral(resourceName: "Edit"),
                                       SelectImage: #imageLiteral(resourceName: "Edit"),
                                       title: "Create",
                                       rootViewController: CreateController())
        
        let History = tabBarNavigation(UnSelectImage: #imageLiteral(resourceName: "History"),
                                      SelectImage: #imageLiteral(resourceName: "History"),
                                      title: "History",
                                      rootViewController: HistoryController())
       
        let Upgrade = tabBarNavigation(UnSelectImage: #imageLiteral(resourceName: "Package"),
                                       SelectImage: #imageLiteral(resourceName: "Package"),
                                       title: "Upgrade",
                                       rootViewController: UpgradeController())
        
        //add tabat viewcontroller
        viewControllers = [Scanner, Create, History, Upgrade]
        
        //remove page Upgrade
//        if PresentPage.StateRemoveAds{
//            viewControllers?.removeLast()
//        }
        
    }
    
    fileprivate func tabBarNavigation(UnSelectImage:UIImage, SelectImage:UIImage, title:String?, rootViewController:UIViewController = UIViewController()) -> UINavigationController{
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = UnSelectImage
        navController.tabBarItem.selectedImage = SelectImage
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        navController.tabBarItem.title = title
        navController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
        return navController
    }
    
    //find index select tabbar
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    
        //remove page Upgrade
//        if PresentPage.StateRemoveAds && (viewControllers!.count == 4){
//            viewControllers?.removeLast()
//        }
        
        return true
    }
    
}


