//
//  test.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 24/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//

import UIKit

class test: UIViewController {
    
    let viewTest : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        view.layer.masksToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        view.addSubview(viewTest)
        viewTest.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 50, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 60)
        
        let width = view.frame.width
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width - 40, height: 60), topLeftRadius: 10, topRightRadius: 10, bottomLeftRadius: 10, bottomRightRadius: 10)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        //shapeLayer.masksToBounds = true
        shapeLayer.fillColor = UIColor.green.cgColor
        
        viewTest.layer.addSublayer(shapeLayer)
    }
    
    
}
