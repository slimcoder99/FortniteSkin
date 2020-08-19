//
//  InAppViewController.swift
//  SuperCleaner
//
//  Created by Nhuom Tang on 8/15/19.
//  Copyright © 2019 Nhuom Tang. All rights reserved.
//

import UIKit
import UIView_Shake
import SwiftyStoreKit
import GoogleMobileAds

enum RewardType {
    case editor
    case gif
}

class InAppViewController: BaseViewController {

    @IBOutlet weak var viewContinue: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor
        self.shake()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func shake(){
        viewContinue.shake(1, withDelta: 10, speed: 0.05) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { [weak self] in
                self?.shake()
            })
        }
    }
    
    func purchase(id: String) {
        SwiftyStoreKit.purchaseProduct(id) {[weak self] (result) in
            switch result {
            case .success(_):
                print("OK")
                PaymentManager.shared.savePurchase()
                self?.showSuccess(message: "Success")
                self?.dismiss(animated: true, completion: nil)
            case .error(let error):
                self?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func restorePurchase() {
        self.showLoading()
        SwiftyStoreKit.restorePurchases { (result) in
            self.hideLoading()
            if result.restoredPurchases.count > 0{
                let datas = result.restoredPurchases.map{$0.productId}
                for item in datas{
                    if PRODUCT_ID_ALL == item{
                        PaymentManager.shared.savePurchase()
                        break
                    }
                }
                self.showSuccess(message: "Success")
                self.dismiss(animated: true, completion: nil)
            }else{
                self.showError(message: "Cannot restore purchase.")
            }
        }
    }
    
    @IBAction func onClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onContinue(_ sender: Any) {
        self.purchase(id: PRODUCT_ID_ALL)
    }
    
    @IBAction func onRestore(_ sender: Any) {
        self.restorePurchase()
    }
}
