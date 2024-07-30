//
//  ScannerPageController.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 6/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds
import Photos

class ScannerPageController: UIViewController, AVCaptureMetadataOutputObjectsDelegate{
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var captureDevice: AVCaptureDevice!
    
    var zoomFactor: Float = 1.0

    var Google_Ads_banner: GADBannerView!

    let btn_Flash: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "Light"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(FlashButtonClicker), for: .touchUpInside)
        return button
    }()
    
    let btn_ScaneImage: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "Image"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(ScaneImageButtonClicker), for: .touchUpInside)
        return button
    }()
    
    let btn_Preview: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "Alert"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(PreviewButtonClicker), for: .touchUpInside)
        return button
    }()
    
    let viewBlackAlpha: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.BlackAlpha(alpha: 0.8)
        return view
    }()
    
    let viewFramefocus: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
       
        let path = UIBezierPath()
        let frame = UIScreen.main.bounds.width / 1.58
        let pi = Double.pi
        
        //top left
        path.move(to: CGPoint(x: 0, y: 40))
        path.addLine(to: CGPoint(x: 0, y: 5))
        path.addArc(withCenter: CGPoint(x: 5, y: 5), radius: 5, startAngle: CGFloat(pi), endAngle: CGFloat(pi*3/2), clockwise: true)
        path.addLine(to: CGPoint(x: 40, y: 0))
        
        //top right
        path.move(to: CGPoint(x: frame - 40, y: 0))
        path.addLine(to: CGPoint(x: frame - 5, y: 0))
        path.addArc(withCenter: CGPoint(x: frame - 5, y: 5), radius: 5, startAngle: CGFloat(-pi/2), endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: frame, y: 40))
        
        //bouutm left
        path.move(to: CGPoint(x: frame, y: frame - 40))
        path.addLine(to: CGPoint(x: frame, y: frame - 5))
        path.addArc(withCenter: CGPoint(x: frame - 5, y:frame - 5), radius: 5, startAngle: 0, endAngle: CGFloat(pi/2), clockwise: true)
        path.addLine(to: CGPoint(x: frame - 40, y: frame))

        //bouutm right
        path.move(to: CGPoint(x: 40, y: frame))
        path.addLine(to: CGPoint(x: 5, y: frame))
        path.addArc(withCenter: CGPoint(x: 5 , y:frame - 5), radius: 5, startAngle: CGFloat(pi/2), endAngle: CGFloat(pi), clockwise: true)
        path.addLine(to: CGPoint(x: 0, y: frame - 40))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.AccentColor!.cgColor
        shapeLayer.lineWidth = 2.5
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(shapeLayer)
        
        return view
    }()
    
    let image_border_focus: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "focus").withTintColor(UIColor.AccentColor!)
        image.alpha = 0
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let cameraZoomslider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.thumbTintColor = UIColor.AccentColor
        
        slider.minimumTrackTintColor = UIColor.AccentColor!
        slider.maximumTrackTintColor = UIColor.white
        
        slider.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        slider.addTarget(self, action: #selector(cameraZoomsDidChange), for: .valueChanged)
        slider.addTarget(self, action: #selector(cameraZoomsDidend), for: .editingDidEnd)

        return slider
    }()
    
    let imageIconZoomIN: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "ZoomIn").withTintColor(.white)
        return image
    }()
    
    let imageIconZoomOut: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "ZoomOut").withTintColor(.white)
        return image
    }()
    
    //
    fileprivate func makeCircleWith(size: CGSize, backgroundColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backgroundColor.cgColor)
        context?.setStrokeColor(UIColor.clear.cgColor)
        let bounds = CGRect(origin: .zero, size: size)
        context?.addEllipse(in: bounds)
        context?.drawPath(using: .fill)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.navigationController?.isNavigationBarHidden = true
        
        SettingScanner()
        SettingElement()
        SettingGoogleAdsBanner()
        
        
        //request permission photo library
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
              
            })
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)

        //remove ads when payment
        if PresentPage.StateRemoveAds == false{
            Google_Ads_banner.load(GADRequest())
        }else{
            Google_Ads_banner.removeFromSuperview()
        }

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func SettingElement(){
        
        view.addSubview(image_border_focus)

        view.addSubview(viewBlackAlpha)
        viewBlackAlpha.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(viewFramefocus)
        
        view.addSubview(btn_Flash)
        view.addSubview(btn_ScaneImage)
        view.addSubview(btn_Preview)
        btn_Flash.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 25, heightConstant: 25)
        btn_ScaneImage.anchor(btn_Flash.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        btn_ScaneImage.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 25, heightConstant: 25)
        btn_Preview.anchor(btn_Flash.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 25, heightConstant: 25)
        
        view.addSubview(cameraZoomslider)
        view.addSubview(imageIconZoomOut)
        view.addSubview(imageIconZoomIN)
        cameraZoomslider.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 30, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        imageIconZoomOut.anchor(nil, left: nil, bottom: nil, right: cameraZoomslider.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: -40, widthConstant: 0, heightConstant: 0)
        imageIconZoomOut.anchorCenter(nil, AxisY: cameraZoomslider.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 25, heightConstant: 25)
        imageIconZoomIN.anchor(nil, left: cameraZoomslider.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: -35, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        imageIconZoomIN.anchorCenter(nil, AxisY: cameraZoomslider.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 25, heightConstant: 25)
        
        
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
        Google_Ads_banner.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
    }

    func SettingScanner(){
        
        captureSession = AVCaptureSession()
        captureDevice = AVCaptureDevice.default(for: .video)
        
        guard (captureDevice != nil) else { return }
        
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
          
            //set type scanner
            metadataOutput.metadataObjectTypes = [.qr,
                                                  .upce,
                                                  .code39,
                                                  .code39Mod43,
                                                  .code93,
                                                  .code128,
                                                  .ean8,
                                                  .ean13,
                                                  .aztec,
                                                  .pdf417,
                                                  .itf14,
                                                  .interleaved2of5,
                                                  .dataMatrix]
            
        } else {
            failed()
            return
        }
        
      
        //set Layer view
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        //QR and barcode area scanner
        let frame = (view.frame.width / 1.58)
        let posX = (view.frame.width / 2) - (frame/2)
        let posY = (view.frame.height / 2) - (frame/2) - 50
        let qrArea = CGRect(x: posX, y: posY, width: frame, height: frame)
    
        //set view black alpha path
        let path = CGMutablePath()
        path.addRect(qrArea)
        path.addRect(CGRect(origin: .zero, size: view.frame.size))
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        maskLayer.fillRule = .evenOdd
        viewBlackAlpha.layer.mask = maskLayer
        viewBlackAlpha.clipsToBounds = true
        

        metadataOutput.rectOfInterest = previewLayer!.metadataOutputRectConverted(fromLayerRect: qrArea)

        captureSession.startRunning()
        
        viewFramefocus.frame = qrArea
    
    }
    
    //touches focus
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let screenSize = previewLayer!.bounds.size
        if let touchPoint = touches.first {
            
            //truch in view Frame focus
            guard touchPoint.view == viewFramefocus else {return}
            
            let x = touchPoint.location(in: self.view).y / screenSize.height
            let y = 1.0 - touchPoint.location(in: self.view).x / screenSize.width
            let focusPoint = CGPoint(x: x, y: y)

            if let device = captureDevice {
                do {
                    try device.lockForConfiguration()
                    //config touch focus
                    device.focusPointOfInterest = focusPoint
                    device.focusMode = .autoFocus
                    device.exposurePointOfInterest = focusPoint
                    device.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
                    device.unlockForConfiguration()
                    
                    image_border_focus.alpha = 0.7
                    image_border_focus.frame = CGRect(x: touchPoint.location(in: self.view).x - 25,
                                                      y: touchPoint.location(in: self.view).y - 25,
                                                      width: 50, height: 50)
                    
                    UIView.animate(withDuration: 0.25, delay: 0.5, options: .curveLinear, animations: {
                        self.image_border_focus.alpha = 0
                     }) { (Sucess : Bool) in
                        //
                    }
                    
                   
                }
                catch {
                    // just ignore
                }
            }
        }
    }
    
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        captureSession.stopRunning()
        btn_Flash.setImage(#imageLiteral(resourceName: "Light"), for: .normal)
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            let metadataObjectType = metadataObject.type.rawValue
            let TypeArr = metadataObjectType.components(separatedBy: ".")
            
            found(code: stringValue, Type: TypeArr.last!)
            
        }

        //dismiss(animated: true)
    }
    
    //result scane
    func found(code: String, Type: String) {
        
        if Type == "QRCode"{
            for index in 0..<3{
                switch index {
                case 0://find web
                    if code.prefix(4) == "http"{
                        
                        let viewPresent = DetailWebController()
                        viewPresent.StateView = "Scane"
                        viewPresent.TextUrl = code
                        viewPresent.Date = GetDate()

                        navigationController?.pushViewController(viewPresent, animated: true)
                        
                        print(code,"WEB")
                        return
                    }
                case 1://find Wifi
                    if code.prefix(4) == "WIFI"{
                        
                        //Refromat WiFi
                        let WiFi = refromatWiFi.init(fromat: code)
                        
                        let viewPresent = DetailWifiController()
                        viewPresent.StateView = "Scane"
                        viewPresent.TextSSID = WiFi.SSID
                        viewPresent.TextPass = WiFi.Pass
                        viewPresent.encryption = WiFi.Enc
                        viewPresent.Date = GetDate()
                        viewPresent.TextCreateWiFi = WiFi.fromatWiFi()

                        navigationController?.pushViewController(viewPresent, animated: true)
            
                        print(code,"WIFI")
                        return
                    }
                default:
                    
                    let viewPresent = DetailTextController()
                    viewPresent.StateView = "Scane"
                    viewPresent.TextView = code
                    
                    navigationController?.pushViewController(viewPresent, animated: true)
                    
                    print(code,"TexT")
                }
                
            }
        }else{
            
            let viewPresent = DetailBarcodeController()
            viewPresent.StateView = "Scane"
            viewPresent.TextBarcode = code
            viewPresent.Date = GetDate()

            navigationController?.pushViewController(viewPresent, animated: true)
            
            print(code,"Barcode")
        }
        
    }
    
    func scanQRFromGallery(qrcodeImg : UIImage) {
        let detector:CIDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])!
        let ciImage:CIImage = CIImage(image:qrcodeImg)!
        var qrCodeLink = ""

        let features=detector.features(in: ciImage)

        for feature in features as! [CIQRCodeFeature] {
            qrCodeLink += feature.messageString!
        }

        if qrCodeLink == "" {
            print("qrCodeLink is empty")
        }
        else{
            found(code: qrCodeLink, Type: "QRCode")
        }
    }
    
    @objc func FlashButtonClicker(){
        toggleFlash()
    }
    
    @objc func ScaneImageButtonClicker(){
        
        //set view Image Picker in device
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.modalPresentationStyle = .fullScreen
        //show Image Picker
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func PreviewButtonClicker(){
        
        let viewPresent = PreviewPageController()
        viewPresent.modalPresentationStyle = .fullScreen
        self.present(viewPresent, animated: true, completion: nil)
    }
    
    @objc func cameraZoomsDidChange(sender: UISlider){

        guard let device = captureDevice else { return }

         func minMaxZoom(_ factor: CGFloat) -> CGFloat { return min(max(factor, 1.0), device.activeFormat.videoMaxZoomFactor) }

         func update(scale factor: CGFloat) {
           do {
             try device.lockForConfiguration()
             defer { device.unlockForConfiguration() }
             device.videoZoomFactor = factor
           } catch {
             debugPrint(error)
           }
         }

        let newScaleFactor = minMaxZoom(CGFloat(sender.value * zoomFactor))
        update(scale: newScaleFactor)

    }
    
    @objc func cameraZoomsDidend(sender: UISlider){

        guard let device = captureDevice else { return }

         func minMaxZoom(_ factor: CGFloat) -> CGFloat { return min(max(factor, 1.0), device.activeFormat.videoMaxZoomFactor) }

         func update(scale factor: CGFloat) {
           do {
             try device.lockForConfiguration()
             defer { device.unlockForConfiguration() }
             device.videoZoomFactor = factor
           } catch {
             debugPrint(error)
           }
         }
        let newScaleFactor = minMaxZoom(CGFloat(sender.value * zoomFactor))
        zoomFactor = Float(minMaxZoom(newScaleFactor))
        update(scale: CGFloat(zoomFactor))
    }
   
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    //toggle Flash
    func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if device.torchMode == AVCaptureDevice.TorchMode.on {
                    device.torchMode = .off
                    btn_Flash.setImage(#imageLiteral(resourceName: "Light"), for: .normal)
                } else {
                    device.torchMode = .on
                    btn_Flash.setImage(#imageLiteral(resourceName: "Light_Full"), for: .normal)
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
        
}


extension ScannerPageController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
         
        scanQRFromGallery(qrcodeImg: image)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ScannerPageController : GADBannerViewDelegate{
    
    // Tells the delegate an ad request loaded an ad.
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        cameraZoomslider.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 20 + 50, rightConstant: 20, widthConstant: 0, heightConstant: 0)
    }
    
}


