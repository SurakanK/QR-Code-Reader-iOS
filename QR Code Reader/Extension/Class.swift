//
//  Class.swift
//  QR Code Reader
//
//  Created by Surakan Kasurong on 21/9/2563 BE.
//  Copyright © 2563 Surakan Kasurong. All rights reserved.
//

import Foundation

class refromatWiFi{

    var fromat = String()
    var SSID = String()
    var Pass = String()
    var Enc = String()
    
    init(fromat:String) {
        //WIFI:S:KASARONG_FM 5G;T:WPA;P:aannaa04;;
        for split in fromat.split(separator: ";"){
                            
            if split.range(of: "S:") != nil{//Check SSID
                self.SSID = String(split.split(separator: ":").last!)
            }else if split.range(of: "P:") != nil{//Check Password
                self.Pass = String(split.split(separator: ":").last!)
            }else if split.range(of: "T:") != nil{//Check Encryption
                self.Enc = String(split.split(separator: ":").last!)
            }
        
        }
    }
    
    func fromatWiFi() -> String {
        return "WIFI:S:" + SSID + ";T:" + Enc + ";P:" + Pass + ";;"
    }
}
