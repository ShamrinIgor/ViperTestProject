//
// Created by VIPER
// Copyright (c) 2020 VIPER. All rights reserved.
//
import SnapKit
import Foundation
import UIKit

class RegView: UIViewController
{
    static let numberOfScreens = 5
//    var viewType: typeOfView = .inputName
    var currentIndexOfScreen: Int?
    var keyboardIsOpen = false

    var backgroundView: UIView = {
        let backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = UIColor(rgb: 0xF7FCFF)
        backgroundView.layer.cornerRadius = 20
        return backgroundView
    }()
    
    var mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        return label
    }()
    
    var progressLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        label.textAlignment = .left
        label.font = UIFont(name: "Circe-Light", size: 15)
        return label
    }()
    
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.titleLabel!.textColor = .white
        button.backgroundColor = .clear
        button.layer.cornerRadius = 30
        return button
    }()
    
    var arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "rightArrow"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    var progressBarView: UIStackView = {
        
        var arr = [UIView]()
        for _ in 0..<numberOfScreens {
            let view = UIView()
            view.layer.backgroundColor = UIColor(rgb: 0x590190).cgColor
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 5
            arr.append(view)
        }

        let stack = UIStackView(arrangedSubviews: arr)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10.0
        stack.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }()
        
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConfiger()
        
        //Hide keyboard on screen tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
                
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setGradientBackground(view: view)
        setGradientBackground(view: nextButton)
    }
    
    // MARK: Fileprivate
    fileprivate func viewConfiger() {
        self.view.backgroundColor = .clear
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
        self.navigationItem.rightBarButtonItem = cancelButton
        //        switch viewType {
//        case .inputName:
//            self.iconImageView.image = UIImage(named: "chat")
//            self.mainLabel.text = "Your name"
//            self.mainLabel.sizeToFit()
//            self.currentIndexOfScreen = typeOfView.inputName.rawValue + 1
//            self.progressLabel.text = "\(100/RegView.numberOfScreens*currentIndexOfScreen!)% complete"
//
//            let inputNameTextField = UITextField()
//            inputNameTextField.textColor = .gray
//            inputNameTextField.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
//            inputNameTextField.textAlignment = .center
//            inputNameTextField.placeholder = "Name"
//
//            backgroundView.addSubview(inputNameTextField)
//
//            inputNameTextField.snp.makeConstraints() { (make) -> Void in
//                make.top.equalToSuperview().offset(90)
//                make.centerX.equalToSuperview()
//            }
//
//        case .birthday:
//            self.iconImageView.image = UIImage(named: "calendar")
//            self.mainLabel.text = "Birthday"
//            self.currentIndexOfScreen = typeOfView.birthday.rawValue + 1
//            self.progressLabel.text = "\(100/RegView.numberOfScreens*currentIndexOfScreen!)% complete"
//
//
//        case .gender:
//            self.iconImageView.image = UIImage(named: "gender")
//            self.mainLabel.text = "Gender"
//            self.currentIndexOfScreen = typeOfView.gender.rawValue + 1
//            self.progressLabel.text = "\(100/RegView.numberOfScreens*currentIndexOfScreen!)% complete"
//
//        case .profilePhoto:
//            self.iconImageView.image = UIImage(named: "camera")
//            self.mainLabel.text = "Profile photo"
//            self.currentIndexOfScreen = typeOfView.profilePhoto.rawValue + 1
//            self.progressLabel.text = "\(100/RegView.numberOfScreens*currentIndexOfScreen!)% complete"
//        default:
//            break
//        }
        
        view.addSubview(progressBarView)
        view.addSubview(iconImageView)
        view.addSubview(mainLabel)
        view.addSubview(progressLabel)
        view.addSubview(backgroundView)
        view.addSubview(nextButton)
        
        nextButton.addSubview(arrowImageView)
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        
        makeConstraints()
    }
    
    
    fileprivate func makeConstraints() {
        
        mainLabel.snp.makeConstraints() { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(130)
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        iconImageView.snp.makeConstraints() { (make) -> Void in
            make.centerY.equalTo(mainLabel.snp.bottom).offset(5)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(10)
            make.width.equalTo(120)
        }
        
        progressLabel.snp.makeConstraints() { (make) -> Void in
            make.top.equalTo(mainLabel.snp.bottom).offset(15)
            make.left.equalTo(mainLabel.snp.left)
            make.right.equalToSuperview()
            make.height.equalTo(35)
        }
        
        progressBarView.snp.makeConstraints() { (make) -> Void in
            make.top.equalTo(progressLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(10)
        }
        
        backgroundView.snp.makeConstraints() { (make) -> Void in
            make.top.equalTo(progressBarView.snp.bottom).offset(35)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(13)
            make.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints() { (make) -> Void in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-25)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
        
        arrowImageView.snp.makeConstraints() { (make) -> Void in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(30)

        }

    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else{return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else{return}
        let keyboardFrame = keyboardSize.cgRectValue.height
        
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        
        if !self.keyboardIsOpen {
            self.nextButton.frame.origin.y -= (keyboardFrame - bottomPadding!)
            self.keyboardIsOpen = true
        }
        

    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo else{return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else{return}
        let keyboardFrame = keyboardSize.cgRectValue.height
        
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        
        if self.keyboardIsOpen {
            self.nextButton.frame.origin.y += (keyboardFrame - bottomPadding!)
            self.keyboardIsOpen = false
        }
        
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc func nextButtonPressed(sender: UIButton!) {
        print("...")
    }
    
    @objc func cancelButtonPressed(sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setProgress(index: Int) {
        for i in 0..<index {
            progressBarView.arrangedSubviews[i].backgroundColor = .white
        }
    }
    
}

enum typeOfView: Int {
    case inputName
    case birthday
    case gender
    case profilePhoto
}
