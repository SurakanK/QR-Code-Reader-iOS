//
//  HistoryCell.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 6/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    let viewMain: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true

        let width = UIScreen.main.bounds.width
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width - 40, height: 60), topLeftRadius: 10, topRightRadius: 10, bottomLeftRadius: 10, bottomRightRadius: 30)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        
        view.layer.addSublayer(shapeLayer)
        
        return view
    }()
    
    let imageLogo: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Website").withTintColor(UIColor.PrimaryColor!)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let imagefavourite: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Star_Full").withTintColor(UIColor.AccentColor!)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let main_imageLogo: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AccentColor
        return view
    }()
    
    let Title_name: UILabel = {
        let label = UILabel()
        label.text = "Google"
        label.textColor = UIColor.PrimaryColor
        label.font = UIFont.NunitoSansBlack(size: 22)
        label.numberOfLines = 0
        return label
    }()
    
    let text_date: UILabel = {
        let label = UILabel()
        label.text = "11/06/20 11:11 PM"
        label.textColor = UIColor.black
        label.font = UIFont.NunitoSansRegular(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        SetupTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
            
    func SetupTableViewCell(){
             
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        self.addSubview(viewMain)
        viewMain.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 5, rightConstant: 20, widthConstant: 0, heightConstant: 60)
       
        viewMain.addSubview(main_imageLogo)
        main_imageLogo.addSubview(imageLogo)
        main_imageLogo.anchor(viewMain.topAnchor, left: viewMain.leftAnchor, bottom: viewMain.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 0)
        imageLogo.anchorCenter(main_imageLogo.centerXAnchor, AxisY: main_imageLogo.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 30, heightConstant: 30)
        
        viewMain.addSubview(imagefavourite)
        imagefavourite.anchorCenter(nil, AxisY: viewMain.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        imagefavourite.anchor(nil, left: nil, bottom: nil, right: viewMain.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 30, heightConstant: 30)
        
        viewMain.addSubview(Title_name)
        Title_name.anchor(viewMain.topAnchor, left: main_imageLogo.rightAnchor, bottom: nil, right: imagefavourite.leftAnchor, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        viewMain.addSubview(text_date)
        text_date.anchor(nil, left: main_imageLogo.rightAnchor, bottom: viewMain.bottomAnchor, right: imagefavourite.leftAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 5, rightConstant: 10, widthConstant: 0, heightConstant: 0)

    }
    
}
