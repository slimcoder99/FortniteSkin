//
//  PaymentManager.swift
//  MasterCleaner
//
//  Created by Nhuom Tang on 7/15/19.
//  Copyright © 2019 Nhuom Tang. All rights reserved.
//

import UIKit

class PaymentManager: NSObject {
    
    static let shared = PaymentManager()
    
    var viewAdsEditor = 0
    var viewAdsGif = 0

    func isPurchase()->Bool{
        let id = "isPurchase"
        let isPurchase = UserDefaults.standard.bool(forKey: id.replacingOccurrences(of: ".", with: ""))
        return isPurchase
    }
    
    func savePurchase(){
        let id = "isPurchase"
        UserDefaults.standard.setValue(true, forKey: id.replacingOccurrences(of: ".", with: ""))
    }
}

