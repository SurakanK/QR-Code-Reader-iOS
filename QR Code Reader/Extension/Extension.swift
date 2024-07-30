//
//  Extension.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 8/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//

import UIKit
import Photos

extension UIImage {
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
       
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.setStrokeColor(UIColor.clear.cgColor)
       
        let bounds = CGRect(origin: .zero, size: size)
        context?.addEllipse(in: bounds)
        context?.drawPath(using: .fill)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage {
      let size = self.size
      let widthRatio  = targetSize.width  / size.width
      let heightRatio = targetSize.height / size.height
      let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
      let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

      UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
      self.draw(in: rect)
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

      return newImage!
    }

}

extension UIViewController{
    
    //generate QR Code
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.utf8)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 30, y: 30)
            if let output = filter.outputImage?.transformed(by: transform) {
                print(output)
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
    func Create_AlertMessage(Title : String!,TitleColor: UIColor, Message : String!){
        
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // Set Attribute Alert
        alert.setTitlet(font: UIFont.NunitoSansBold(size: 20), color: TitleColor)
        alert.setMessage(font: UIFont.NunitoSansRegular(size: 16), color: .black)
        
        self.present(alert, animated: true, completion: nil)
    }
        
    // MARK: Save Image to Album
    func SavePoto(imageQRcode:UIImageView){
        // Get Alabum for Store Image Capture
        getAlbum(title: "QRcode Reader") { (_) in}
        let pngdata = imageQRcode.image!.pngData()
        let image = UIImage(data: pngdata!)

        save(photo: image!, toAlbum: "QRcode Reader") { (State, error) in
            
            if State {
                print("Complete")
                
                DispatchQueue.main.async { // Correct
                    self.Create_AlertMessage(Title: "Save", TitleColor: .black, Message: "save qrcode to photo library.")
                }
                
            }else {
                print(error!)
                
                DispatchQueue.main.async { // Correct
                    self.Create_AlertMessage(Title: "Error", TitleColor: .systemRed, Message: "Please check permissions photo library.")
                }
                
            }
        }
    }
    
    func createAlbum(withTitle title: String, completionHandler: @escaping (PHAssetCollection?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            var placeholder: PHObjectPlaceholder?
            
            PHPhotoLibrary.shared().performChanges({
                let createAlbumRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: title)
                placeholder = createAlbumRequest.placeholderForCreatedAssetCollection
            }, completionHandler: { (created, error) in
                var album: PHAssetCollection?
                if created {
                    let collectionFetchResult = placeholder.map { PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [$0.localIdentifier], options: nil) }
                    album = collectionFetchResult?.firstObject
                }
                
                completionHandler(album)
            })
        }
    }
    
    func getAlbum(title: String, completionHandler: @escaping (PHAssetCollection?) -> ()) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "title = %@", title)
            let collections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
            
            if let album = collections.firstObject {
                completionHandler(album)
            } else {
                self?.createAlbum(withTitle: title, completionHandler: { (album) in
                    completionHandler(album)
                })
            }
        }
    }
    
    func save(photo: UIImage, toAlbum titled: String, completionHandler: @escaping (Bool, Error?) -> ()) {
        getAlbum(title: titled) { (album) in
            DispatchQueue.global(qos: .background).async {
                PHPhotoLibrary.shared().performChanges({
                    let assetRequest = PHAssetChangeRequest.creationRequestForAsset(from: photo)
                    let assets = assetRequest.placeholderForCreatedAsset
                        .map { [$0] as NSArray } ?? NSArray()
                    let albumChangeRequest = album.flatMap { PHAssetCollectionChangeRequest(for: $0) }
                    albumChangeRequest?.addAssets(assets)
                }, completionHandler: { (success, error) in
                    completionHandler(success, error)
                })
                
            }
        }
    }
    //--------------------------------------------------------------------------
    
    func GetDate() -> String{
        
        // data sub Header Quotation date
        let date = Date()
        let formatter = DateFormatter()
               
        // date for qoutation
        formatter.dateFormat = "dd/MM/YY HH:mm a"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
}

extension UIView {
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    
    //ImageView to uiimage
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension UIBezierPath {
    public convenience init(roundedRect rect: CGRect, topLeftRadius: CGFloat?, topRightRadius: CGFloat?, bottomLeftRadius: CGFloat?, bottomRightRadius: CGFloat?) {
        self.init()

        assert(((bottomLeftRadius ?? 0) + (bottomRightRadius ?? 0)) <= rect.size.width)
        assert(((topLeftRadius ?? 0) + (topRightRadius ?? 0)) <= rect.size.width)
        assert(((topLeftRadius ?? 0) + (bottomLeftRadius ?? 0)) <= rect.size.height)
        assert(((topRightRadius ?? 0) + (bottomRightRadius ?? 0)) <= rect.size.height)

        // corner centers
        let tl = CGPoint(x: rect.minX + (topLeftRadius ?? 0), y: rect.minY + (topLeftRadius ?? 0))
        let tr = CGPoint(x: rect.maxX - (topRightRadius ?? 0), y: rect.minY + (topRightRadius ?? 0))
        let bl = CGPoint(x: rect.minX + (bottomLeftRadius ?? 0), y: rect.maxY - (bottomLeftRadius ?? 0))
        let br = CGPoint(x: rect.maxX - (bottomRightRadius ?? 0), y: rect.maxY - (bottomRightRadius ?? 0))

        //let topMidpoint = CGPoint(rect.midX, rect.minY)
        let topMidpoint = CGPoint(x: rect.midX, y: rect.minY)

        makeClockwiseShape: do {
            self.move(to: topMidpoint)

            if let topRightRadius = topRightRadius {
                self.addLine(to: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY))
                self.addArc(withCenter: tr, radius: topRightRadius, startAngle: -CGFloat.pi/2, endAngle: 0, clockwise: true)
            }
            else {
                self.addLine(to: tr)
            }

            if let bottomRightRadius = bottomRightRadius {
                self.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRightRadius))
                self.addArc(withCenter: br, radius: bottomRightRadius, startAngle: 0, endAngle: CGFloat.pi/2, clockwise: true)
            }
            else {
                self.addLine(to: br)
            }

            if let bottomLeftRadius = bottomLeftRadius {
                self.addLine(to: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY))
                self.addArc(withCenter: bl, radius: bottomLeftRadius, startAngle: CGFloat.pi/2, endAngle: CGFloat.pi, clockwise: true)
            }
            else {
                self.addLine(to: bl)
            }

            if let topLeftRadius = topLeftRadius {
                self.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeftRadius))
                self.addArc(withCenter: tl, radius: topLeftRadius, startAngle: CGFloat.pi, endAngle: -CGFloat.pi/2, clockwise: true)
            }
            else {
                self.addLine(to: tl)
            }

            self.close()
        }
    }
}

