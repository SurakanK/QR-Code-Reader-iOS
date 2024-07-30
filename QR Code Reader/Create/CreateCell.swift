//
//  CreateCell.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 7/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//

import UIKit

class CreateCell: UICollectionViewCell {
    
    let image_Logo: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Website").withTintColor(UIColor.PrimaryColor!)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let Title_Create: UILabel = {
        let label = UILabel()
        label.text = "Website"
        label.textColor = UIColor.PrimaryColor
        label.font = UIFont.NunitoSansBlack(size: 22)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
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
        
        //Setting basic cell
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.16).cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 6
       
        //setting element in cell
        self.addSubview(image_Logo)
        let heightLogo = (self.frame.width - 60)
        image_Logo.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 30, leftConstant: 30, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: heightLogo)
        
        self.addSubview(Title_Create)
        Title_Create.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
}
