//
//  ItemCVC.swift
//  ForniteSkin
//
//  Created by manhpro on 8/17/20.
//  Copyright © 2020 SwiftifyTeam. All rights reserved.
//

import UIKit

class ItemCVC: UICollectionViewCell {
    
    static let className = "ItemCVC"
    
    @IBOutlet weak var rectangleImage: UIImageView!
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var tickImage: UIImageView!
    
    var index: Int?
    
    var gender: CustomPageVC.Gender = .male
    
    var selectionType: CustomPageVC.SelectionType = .face
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        rectangleImage.contentMode = .scaleAspectFit
        itemImage.contentMode = .scaleAspectFit
        tickImage.contentMode = .scaleAspectFit
    }

    func setupCell(_ index: Int, _ gender: CustomPageVC.Gender, _ selectionType: CustomPageVC.SelectionType) {
        
        self.index = index
        self.gender = gender
        self.selectionType = selectionType
        tickImage.image = UIImage(named: "tick")
        tickImage.isHidden = true
        var imageName = ""
        
        if gender == .male {
            rectangleImage.image = UIImage(named: "Rectangle")
            rectangleImage.isHidden = false
            itemImage.layer.cornerRadius = 0
            itemImage.clipsToBounds = false
            itemImage.contentMode = .scaleAspectFit
            if selectionType == .face {
                imageName = "h\(index)_Normal"
            }
            
            else if selectionType == .shirt {
                imageName = "b\(index)_Normal"
            }
            
            else if selectionType == .pants {
                imageName = "l\(index)_Normal"
            }
            
            else if selectionType == .background {
                rectangleImage.isHidden = true
                itemImage.layer.cornerRadius = 5
                itemImage.clipsToBounds = true
                itemImage.contentMode = .scaleAspectFill
                imageName = "background\(index)"
            }
        }
        
        else {
            rectangleImage.image = UIImage(named: "wRectangle")
            rectangleImage.isHidden = false
            itemImage.layer.cornerRadius = 0
            itemImage.clipsToBounds = false
            itemImage.contentMode = .scaleAspectFit
            if selectionType == .face {
                imageName = "wh\(index)_Normal"
            }
            
            else if selectionType == .shirt {
                imageName = "wb\(index)_Normal"
            }
            
            else if selectionType == .pants {
                imageName = "wl\(index)_Normal"
            }
            
            else if selectionType == .background {
                rectangleImage.isHidden = true
                itemImage.layer.cornerRadius = 5
                itemImage.clipsToBounds = true
                itemImage.contentMode = .scaleAspectFill
                imageName = "background\(index)"
            }
            
        }
        itemImage.image = UIImage(named: imageName)
        itemImage.image?.alpha(1)
    }
}
