//
//  HomePageVC.swift
//  ForniteSkin
//
//  Created by manhpro on 8/17/20.
//  Copyright © 2020 SwiftifyTeam. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var wbImage: UIImageView!
    
    @IBOutlet weak var wlImage: UIImageView!
    
    @IBOutlet weak var whImage: UIImageView!
    
    @IBOutlet weak var bImage: UIImageView!
    
    @IBOutlet weak var lImage: UIImageView!
    
    @IBOutlet weak var hImage: UIImageView!
        
    @IBOutlet weak var soundButton: UIButton!
    
    @IBOutlet weak var settingButton: UIButton!
    
    var playerName = ""
    
    let firstContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 5
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.systemPurple.cgColor
        button.backgroundColor = UIColor.init(red: 187, green: 107, blue: 217)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Margarine-Regular", size: 15)
        button.addTarget(self, action: #selector(handleStartButton), for: .touchUpInside)
        
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemGray2
        label.font = UIFont(name: "Margarine-Regular", size: 15)
        label.text = "What's your name?"
        
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 5
        textField.clipsToBounds = true
        textField.layer.borderColor = UIColor.systemPurple.cgColor
        textField.backgroundColor = UIColor.init(red: 187, green: 107, blue: 217)
        textField.textAlignment = .center
        textField.font = UIFont(name: "Margarine-Regular", size: 15)
        
        return textField
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemGray2
        label.font = UIFont(name: "Margarine-Regular", size: 15)
        
        return label
    }()
        
    let maleButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.systemPurple.cgColor
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.init(red: 187, green: 107, blue: 217)
        button.setTitle("Male", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Margarine-Regular", size: 15)
        button.addTarget(self, action: #selector(handleMale), for: .touchUpInside)
        
        return button
    }()

    let femaleButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.systemPurple.cgColor
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.init(red: 187, green: 107, blue: 217)
        button.setTitle("Female", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Margarine-Regular", size: 15)
        button.addTarget(self, action: #selector(handleFemale), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup Elements
        setupElements()
        
        self.addDoneButtonOnKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupElements()
    }
    
    func setupElements() {
        self.navigationController?.navigationBar.isHidden = true
        view.addSubview(containerView)
        
        startButton.isHidden = false
        nameLabel.isHidden = true
        nameTextField.isHidden = true
        genderLabel.isHidden = true
        maleButton.isHidden = true
        femaleButton.isHidden = true
        
        coverImage.contentMode = .scaleAspectFill
        coverImage.image = UIImage(named: "Home_Page")
        
        titleLabel.textAlignment = . center
        titleLabel.font = UIFont.init(name: "Margarine-Regular", size: 50)
        titleLabel.textColor = .white
        titleLabel.text = "Fort Skin"
        
        wbImage.contentMode = .scaleAspectFit
        wbImage.image = UIImage(named: "wb7_Normal")
        wlImage.contentMode = .scaleAspectFit
        wlImage.image = UIImage(named: "wl8_Normal")
        whImage.contentMode = .scaleAspectFit
        whImage.image = UIImage(named: "wh8_Normal")
        
        bImage.contentMode = .scaleAspectFit
        bImage.image = UIImage(named: "b33_Normal")
        lImage.contentMode = .scaleAspectFit
        lImage.image = UIImage(named: "l26_Normal")
        hImage.contentMode = .scaleAspectFit
        hImage.image = UIImage(named: "h18_Normal")
        
        view.addSubview(firstContainerView)
        firstContainerView.translatesAutoresizingMaskIntoConstraints = false
        firstContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        firstContainerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        firstContainerView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8).isActive = true
        firstContainerView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.3).isActive = true
        
        firstContainerView.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.centerXAnchor.constraint(equalTo: firstContainerView.centerXAnchor).isActive = true
        startButton.widthAnchor.constraint(equalTo: firstContainerView.widthAnchor, multiplier: 1/3).isActive = true
        startButton.heightAnchor.constraint(equalTo: firstContainerView.heightAnchor, multiplier: 0.2).isActive = true
        startButton.bottomAnchor.constraint(equalTo: firstContainerView.bottomAnchor, constant: -80).isActive = true
    }
    
    func setupSecondView() {
        startButton.isHidden = true
        nameLabel.isHidden = false
        nameTextField.isHidden = false
        genderLabel.isHidden = true
        maleButton.isHidden = true
        femaleButton.isHidden = true
        nameTextField.text = ""
        firstContainerView.addSubview(nameTextField)
        firstContainerView.addSubview(nameLabel)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.centerXAnchor.constraint(equalTo: firstContainerView.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: firstContainerView.widthAnchor, multiplier: 1/2).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: firstContainerView.heightAnchor, multiplier: 0.25).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: firstContainerView.bottomAnchor, constant: -70).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: firstContainerView.topAnchor, constant: 50).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: firstContainerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: firstContainerView.trailingAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: nameTextField.topAnchor).isActive = true
    }
    
    func setupThirdView() {
        playerName = nameTextField.text!
        startButton.isHidden = true
        nameLabel.isHidden = true
        nameTextField.isHidden = true
        genderLabel.isHidden = false
        maleButton.isHidden = false
        femaleButton.isHidden = false
        
        firstContainerView.addSubview(genderLabel)
        firstContainerView.addSubview(maleButton)
        firstContainerView.addSubview(femaleButton)
        
        maleButton.translatesAutoresizingMaskIntoConstraints = false
        maleButton.centerXAnchor.constraint(equalTo: firstContainerView.centerXAnchor, constant: -60).isActive = true
        maleButton.widthAnchor.constraint(equalTo: firstContainerView.widthAnchor, multiplier: 0.3).isActive = true
        maleButton.heightAnchor.constraint(equalTo: firstContainerView.heightAnchor, multiplier: 0.2).isActive = true
        maleButton.bottomAnchor.constraint(equalTo: firstContainerView.bottomAnchor, constant: -80).isActive = true
        
        femaleButton.translatesAutoresizingMaskIntoConstraints = false
        femaleButton.centerXAnchor.constraint(equalTo: firstContainerView.centerXAnchor, constant: 60).isActive = true
        femaleButton.widthAnchor.constraint(equalTo: firstContainerView.widthAnchor, multiplier: 0.3).isActive = true
        femaleButton.heightAnchor.constraint(equalTo: firstContainerView.heightAnchor, multiplier: 0.2).isActive = true
        femaleButton.bottomAnchor.constraint(equalTo: firstContainerView.bottomAnchor, constant: -80).isActive = true
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.topAnchor.constraint(equalTo: firstContainerView.topAnchor, constant: 50).isActive = true
        genderLabel.leadingAnchor.constraint(equalTo: firstContainerView.leadingAnchor).isActive = true
        genderLabel.trailingAnchor.constraint(equalTo: firstContainerView.trailingAnchor).isActive = true
        genderLabel.bottomAnchor.constraint(equalTo: maleButton.topAnchor).isActive = true
        genderLabel.text = "Hi \(playerName)! Please select your gender!"
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        nameTextField.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        if nameTextField.text != nil && nameTextField.text != "" {
            setupThirdView()
        }
        nameTextField.resignFirstResponder()
    }
    
    @objc func handleStartButton() {
        print("Hide this container view")
        setupSecondView()
    }
    
    @objc func handleMale() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let customPageVC = storyboard.instantiateViewController(identifier: "CustomPageVC") as? CustomPageVC
        if let customPageVC = customPageVC {
            customPageVC.gender = .male
            self.navigationController?.pushViewController(customPageVC, animated: true)
        }
    }
    
    @objc func handleFemale() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let customPageVC = storyboard.instantiateViewController(identifier: "CustomPageVC") as? CustomPageVC
        if let customPageVC = customPageVC {
            customPageVC.gender = .female
            self.navigationController?.pushViewController(customPageVC, animated: true)
        }
    }
    
    @IBAction func handleSound(_ sender: Any) {
        print("Handle sound")
    }
    
    @IBAction func handleSetting(_ sender: Any) {
        print("handle setting")
    }
}
