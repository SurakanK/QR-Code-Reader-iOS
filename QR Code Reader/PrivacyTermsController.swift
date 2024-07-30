//
//  File.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 8/5/2564 BE.
//  Copyright © 2564 BE Surakan Kasurong. All rights reserved.
//

import UIKit

class PrivacyTermsController: UIViewController {
    
    var state = ""
    var htmlString = ""
    
    let Btn_Cancel: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.NunitoSansExtraBold(size: 17)
        button.addTarget(self, action: #selector(dismissPage), for: .touchUpInside)
        return button
    }()
    
    let TextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.NunitoSansRegular(size: 17)
        textView.textColor = UIColor.systemGray
        return textView
    }()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        view.backgroundColor = UIColor.white
        
        view.addSubview(Btn_Cancel)
        Btn_Cancel.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 5, widthConstant: 100, heightConstant: 50)
        
        view.addSubview(TextView)
        TextView.anchor(Btn_Cancel.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        if (state == "Privacy") {
            htmlString = String.privacy
        } else {
            htmlString = String.terms
        }
        
        let htmlData = NSString(string: htmlString).data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        TextView.attributedText = attributedString
    }
    
    @objc func dismissPage() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
