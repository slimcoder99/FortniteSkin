//
//  CustomPageVC.swift
//  ForniteSkin
//
//  Created by manhpro on 8/17/20.
//  Copyright © 2020 SwiftifyTeam. All rights reserved.
//

import UIKit

class CustomPageVC: UIViewController {
    
    enum SelectionType {
        case shirt
        case pants
        case face
        case background
        case backLight
    }
    
    enum Gender {
        case male
        case female
    }

    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var leftContainerView: UIView!
    
    @IBOutlet weak var barView: UIView!
    
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var backView: UIImageView!
    
    @IBOutlet weak var bodyImage: UIImageView!
    
    @IBOutlet weak var legImage: UIImageView!
    
    @IBOutlet weak var headImage: UIImageView!
    
    @IBOutlet weak var homeButton: UIButton!
    
    var selectionIndexPath = IndexPath(row: 10000, section: 0)
    
    var selectionType: SelectionType = .face
    
    var gender: Gender = .male
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // setupElements
        setupElements()
        
        // setup CollectionView
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        determineMyDeviceOrientation()
    }
    
   func determineMyDeviceOrientation()
    {
        if UIDevice.current.orientation.isLandscape {
            print("Device is in landscape mode")
        } else {
            print("Device is in portrait mode")
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        determineMyDeviceOrientation()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }
    
    func setupElements() {
        view.backgroundColor = .clear
        containerView.backgroundColor = .clear
        
        coverImage.contentMode = .scaleAspectFill
        typeLabel.backgroundColor = .clear
        typeLabel.font = UIFont(name: "Margarine-Regular", size: 16)
        typeLabel.textColor = .systemGray2
        typeLabel.text = "SELECT FACE"
        bodyImage.contentMode = .scaleAspectFit
        legImage.contentMode = .scaleAspectFit
        headImage.contentMode = .scaleAspectFit
        
        homeButton.layer.borderWidth = 5
        homeButton.layer.borderColor = UIColor.systemPurple.cgColor
        homeButton.layer.cornerRadius = 5
        homeButton.backgroundColor = UIColor.init(red: 187, green: 107, blue: 217)
        homeButton.setTitle("Home", for: .normal)
        homeButton.setTitleColor(.black, for: .normal)
        homeButton.titleLabel?.font = UIFont(name: "Margarine-Regular", size: 15)
        
        if gender == .male {
            leftContainerView.backgroundColor = UIColor.init(red: 16, green: 14, blue: 18)
            leftContainerView.alpha = 0.9
            barView.backgroundColor = UIColor.init(red: 16, green: 14, blue: 18)
            barView.alpha = 0.9
            
            coverImage.image = UIImage(named: "background1")
            
            bodyImage.image = UIImage(named: "b2_Normal")
            legImage.image = UIImage(named: "l34_Normal")
            headImage.image = UIImage(named: "h30_Normal")
        }
        
        else {
            leftContainerView.backgroundColor = UIColor.init(red: 69, green: 16, blue: 118)
            leftContainerView.alpha = 0.9
            barView.backgroundColor = UIColor.init(red: 69, green: 16, blue: 118)
            barView.alpha = 0.9
            coverImage.image = UIImage(named: "background2")
            
            bodyImage.image = UIImage(named: "wb1_Normal")
            legImage.image = UIImage(named: "wl20_Normal")
            headImage.image = UIImage(named: "wh34_Normal")
        }
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: ItemCVC.className, bundle: nil), forCellWithReuseIdentifier: ItemCVC.className)
        var cellWidth = 0
        if UIDevice.current.userInterfaceIdiom == .pad {
            cellWidth = Int(self.collectionView.frame.width) / 7 - 10
        } else {
            cellWidth = Int(self.collectionView.frame.width) / 5 - 20
        }
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: cellWidth, height: (cellWidth * 120) / 90)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.reloadData()
    }
    
    @IBAction func handlePrevious(_ sender: Any) {
        if selectionType == .background {
            selectionType = .pants
            typeLabel.text = "SELECT PANTS"
            collectionView.reloadData()
        }
        else if selectionType == .pants {
            selectionType = .shirt
            typeLabel.text = "SELECT SHIRT"
            collectionView.reloadData()
        }
        else if selectionType == .shirt {
            selectionType = .face
            typeLabel.text = "SELECT FACE"
            collectionView.reloadData()
        }
        else if selectionType == .face {
            print("Nothing Left!")
        }
    }
    
    @IBAction func handleNext(_ sender: Any) {
        if selectionType == .face {
            selectionType = .shirt
            typeLabel.text = "SELECT SHIRT"
            collectionView.reloadData()
        }
        else if selectionType == .shirt {
            selectionType = .pants
            typeLabel.text = "SELECT PANTS"
            collectionView.reloadData()
        }
        else if selectionType == .pants {
            selectionType = .background
            typeLabel.text = "SELECT BACKGROUND"
            collectionView.reloadData()
        }
        else if selectionType == .background {
            print("Done!")
        }
    }
    
    @IBAction func handleHome(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CustomPageVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if gender == .male {
            if selectionType == .face {
                return 57
            }
            else if selectionType == .shirt {
                return 36
            }
            else if selectionType == .pants {
                return 34
            }
            else {
                return 6
            }
        }
        
        else {
            if selectionType == .face {
                return 48
            }
            else if selectionType == .shirt {
                return 32
            }
            else if selectionType == .pants {
                return 34
            }
            else {
                return 6
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCVC.className, for: indexPath) as! ItemCVC
        cell.setupCell(indexPath.row + 1, self.gender, self.selectionType)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectionIndexPath.row != 10000 {
            let previousCell = collectionView.cellForItem(at: selectionIndexPath) as? ItemCVC
            if let previousCell = previousCell {
                previousCell.tickImage.isHidden = true
            }
        }
        selectionIndexPath = indexPath
        let cell = collectionView.cellForItem(at: indexPath) as! ItemCVC
        cell.tickImage.isHidden = false
        if gender == .male {
            if selectionType == .face {
                DispatchQueue.main.async {
                    self.headImage.image = UIImage(named: "h\(indexPath.row + 1)_Normal")
                }
            }
            else if selectionType == .shirt {
                DispatchQueue.main.async {
                    self.bodyImage.image = UIImage(named: "b\(indexPath.row + 1)_Normal")
                }
            }
            else if selectionType == .pants {
                DispatchQueue.main.async {
                    self.legImage.image = UIImage(named: "l\(indexPath.row + 1)_Normal")
                }
            }
            else if selectionType == .background {
                DispatchQueue.main.async {
                    self.coverImage.image = UIImage(named: "background\(indexPath.row + 1)")
                }
            }
        }
        else {
            if selectionType == .face {
                DispatchQueue.main.async {
                    self.headImage.image = UIImage(named: "wh\(indexPath.row + 1)_Normal")
                }
            }
            else if selectionType == .shirt {
                DispatchQueue.main.async {
                    self.bodyImage.image = UIImage(named: "wb\(indexPath.row + 1)_Normal")
                }
            }
            else if selectionType == .pants {
                DispatchQueue.main.async {
                    self.legImage.image = UIImage(named: "wl\(indexPath.row + 1)_Normal")
                }
            }
            else if selectionType == .background {
                DispatchQueue.main.async {
                    self.coverImage.image = UIImage(named: "background\(indexPath.row + 1)")
                }
            }
        }
    }
}

extension CustomPageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if selectionType == .background {
                return CGSize(width: (self.collectionView.frame.width) / 5 - 10, height: (self.collectionView.frame.width) / 3 - 10)
            }
            return CGSize(width: (self.collectionView.frame.width - 30) / 7, height: (self.collectionView.frame.width - 30) / 7)
        } else {
            if selectionType == .background {
                return CGSize(width: (self.collectionView.frame.width) / 3 - 10, height: (self.collectionView.frame.height) / 4 - 10)
            }
            else {
                return CGSize(width: (self.collectionView.frame.width) / 5 - 10, height: (self.collectionView.frame.width) / 5 - 10)
            }
        }
    }
}
