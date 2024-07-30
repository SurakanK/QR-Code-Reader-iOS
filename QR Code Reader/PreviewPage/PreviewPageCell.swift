//
//  PreviewPageCell.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 3/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//

import UIKit

class PreviewPageCell: UICollectionViewCell {
    
    let Title_Header: UILabel = {
        let label = UILabel()
        label.text = "Scaner"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.NunitoSansBlack(size: 37)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.shadowRadius = 2
        label.layer.shadowOpacity = 6
        return label
    }()
    
    let view_imageLogo: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.PrimaryColor
        view.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 6
        return view
    }()
    
    let view_imageLogo_background: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteAlpha(alpha: 0.16)
        return view
    }()
    
    let imageLogo: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Preview_Scan")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    let Text_Discription: UILabel = {
        let label = UILabel()
        label.text = "This application can scan QR Code and Barcode."
        label.textColor = .white
        label.font = UIFont.NunitoSansRegular(size: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        SettingElementCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SettingElementCell(){
        
        let frameWidht = self.frame.width
        
        self.backgroundColor = UIColor.PrimaryColor
        
        self.addSubview(Title_Header)
        
        Title_Header.anchor(self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.addSubview(view_imageLogo)
        view_imageLogo.addSubview(view_imageLogo_background)
        view_imageLogo.addSubview(imageLogo)
    
        view_imageLogo.anchor(self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 100, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: frameWidht - 100, heightConstant: frameWidht - 100)
        view_imageLogo.layer.cornerRadius = (frameWidht - 100) / 2
        
        view_imageLogo_background.anchor(view_imageLogo.topAnchor, left: view_imageLogo.leftAnchor, bottom: view_imageLogo.bottomAnchor, right: view_imageLogo.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        view_imageLogo_background.layer.cornerRadius = (frameWidht - 100) / 2
        
        imageLogo.anchor(view_imageLogo.topAnchor, left: view_imageLogo.leftAnchor, bottom: view_imageLogo.bottomAnchor, right: view_imageLogo.rightAnchor, topConstant: 70, leftConstant: 70, bottomConstant: 70, rightConstant: 70, widthConstant: 0, heightConstant: 0)
        
        self.addSubview(Text_Discription)
        
        Text_Discription.anchor(view_imageLogo.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 20, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 0)
    }
    
}
