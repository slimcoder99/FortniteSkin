//
//  YRNewPurchaseViewController.swift
//  YellowRose
//
//  Created by Huy Nguyen on 8/22/19.
//  Copyright © 2019 Huy Nguyen. All rights reserved.
//

import UIKit
import SwiftyStoreKit
import SVProgressHUD


let id_life_time = "purchase_id"

class YRNewPurchaseViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cancelAction: (() -> Void)?
    var letItGoAction: (() -> ())?
    
    var items: [PurchaseItem] = [PurchaseItem(name: "Unlimited reading", localPrice: "--", purchaseID: id_life_time)]
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.alwaysBounceVertical = false
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        let ids = Set(items.compactMap({$0.purchaseID}))
        SwiftyStoreKit.retrieveProductsInfo(ids) { [weak self](results) in
            guard let self = self else { return }
            for product in results.retrievedProducts {
                if let index = self.items.firstIndex(where: {$0.purchaseID == product.productIdentifier}) {
                    self.items[index].localPrice = product.localizedPrice ?? ""
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
            }
        }
    }

    @IBAction func purchaseOntap(_ sender: Any) {
        SVProgressHUD.show()
        SwiftyStoreKit.purchaseProduct(items.compactMap({$0.purchaseID})[selectedIndex]) { [weak self](results) in
            SVProgressHUD.dismiss()
            var purchaseSave = Purchase.get()
            switch results {
            case .success(let purchase):
                
                switch purchase.productId {
                case id_filter:
                    purchaseSave.isFilterUnlocked = true
                    
                case id_chat:
                    purchaseSave.isChatUnlocked = true
                    
                case id_life_time:
                    purchaseSave.isAllUnlock = true
                    
                default:
                    break
                }
                
                purchaseSave.save()
                
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
                self?.dismiss(animated: true, completion: self?.letItGoAction)
            case .error (let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func restoreOntap(_ sender: Any) {
        SVProgressHUD.show()
        SwiftyStoreKit.restorePurchases { [weak self](resutls) in
            var needToDissmiss: Bool = false
            
            var purchase = Purchase.get()
            for product in resutls.restoredPurchases {
                switch product.productId {
                case id_filter:
                    purchase.isFilterUnlocked = true
                    needToDissmiss = true
                case id_chat:
                    purchase.isChatUnlocked = true
                    needToDissmiss = true
                case id_life_time:
                    purchase.isAllUnlock = true
                    needToDissmiss = true
                default:
                    break
                }
            }
            
            purchase.save()
            
            if needToDissmiss {
                SVProgressHUD.dismiss()
                
                self?.dismiss(animated: true, completion: self?.letItGoAction)
            } else {
                SVProgressHUD.showError(withStatus: "Could not find any purchase history")
            }
        }
    }
    
    @IBAction func cancelOntap(_ sender: Any) {
        dismiss(animated: true, completion: cancelAction)
    }
    
}

extension YRNewPurchaseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PurchaseCell.className, for: indexPath) as! PurchaseCell
        var isPurchase = false
        let purchase = Purchase.get()
        switch indexPath.row {
        case 0:
            isPurchase = purchase.isFilterUnlocked || purchase.isAllUnlock
        case 1:
            isPurchase = purchase.isChatUnlocked || purchase.isAllUnlock
        default:
            isPurchase = purchase.isAllUnlock
        }
        cell.config(item: items[indexPath.row], isSelected: selectedIndex == indexPath.row, isPurchase: isPurchase)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
        if let indexPaths = tableView.indexPathsForVisibleRows {
            tableView.reloadRows(at: indexPaths, with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let purchase = Purchase.get()
        switch indexPath.row {
        case 0:
            return !purchase.isFilterUnlocked && !purchase.isAllUnlock
        case 1:
            return !purchase.isChatUnlocked && !purchase.isAllUnlock
        case 2:
            return !purchase.isAllUnlock
        default:
            return true
        
        }
    }
    
}

struct PurchaseItem {
    var name: String
    var localPrice: String
    var purchaseID: String
}

class PurchaseCell: UITableViewCell {
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imvIcon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSub: UILabel!
    
    func config(item: PurchaseItem, isSelected: Bool = false, isPurchase: Bool) {
        lbSub.text = item.localPrice
        imvIcon.image = UIImage(named: isSelected || isPurchase ? "purchase_selected" : "purchase_unselect")
        lbSub.textColor = isSelected ? UIColor.main : UIColor.black
        lbTitle.textColor = isSelected ? UIColor.main : UIColor.black
        vwContainer.backgroundColor = isSelected ? UIColor.main.alpha(0.3) : UIColor(hex: "EEEEEE")
        
        let attrString = NSAttributedString(string: item.name, attributes: isPurchase ? [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue] : [:])
        lbTitle.attributedText = attrString
    }
}

struct Purchase: Codable {
    
    var isFilterUnlocked: Bool = false
    var isChatUnlocked: Bool = false
    var isAllUnlock: Bool = false
    
    func save() {
        saveToUserDefault(for: "Purchase_Saved_Key")
    }
    
    static func get() -> Purchase {
        guard let purchase = getValueFromUserDefaults(for: "Purchase_Saved_Key") else { return Purchase() }
        return purchase
    }
    
}

extension UIColor {
    
    static let main = UIColor(hex: "#F7B20A")
    
}


let id_filter = "dating.app.4gay.ios.com.filters"
let id_chat = "dating.app.4gay.ios.com.chat"

let day: TimeInterval = 86400
let month  = day * 30
let year = month * 12


extension Encodable {
    
    func saveToUserDefault(for key: String? = nil) {
        let userDF = UserDefaults.standard
        let data = try? JSONEncoder().encode(self)
        let otherKey = key ?? String(describing: Self.self)
        userDF.set(data, forKey: otherKey)
        userDF.synchronize()
    }
}

extension Decodable {
    
    static func getValueFromUserDefaults(for key: String? = nil) -> Self? {
        let userDF = UserDefaults.standard
        let otherKey = key ?? String(describing: Self.self)
        guard let data = userDF.value(forKey: otherKey) as? Data else { return nil }
        return try? JSONDecoder().decode(Self.self, from: data)
    }
    
}
