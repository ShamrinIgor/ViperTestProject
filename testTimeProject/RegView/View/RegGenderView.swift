import SnapKit
import Foundation
import UIKit

class RegGenderView: RegView ,RegViewProtocol {
    var presenter: RegViewPresenterProtocol?
    
    var choosenGender: Gender = .male
    
    var maleHatLabel: UILabel = {
        let label = UILabel()
        label.text = "🎩"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 50)
        return label
    }()
    
    var maleButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 6
        button.layer.borderColor = UIColor(rgb: 0xCE5EDF).cgColor
        return button
    }()
    
    var femaleHatLabel: UILabel = {
        let label = UILabel()
        label.text = "👒"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 50)
        return label
    }()
    
    var femaleButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 0
        button.layer.borderColor = UIColor(rgb: 0xCE5EDF).cgColor
        return button
    }()
    
    var maleTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Male"
        label.textAlignment = .center
        label.font = UIFont(name: "Circe-Regular", size: 25)
        label.textColor = UIColor(rgb: 0x590190)
        return label
    }()
    
    var femaleTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Female"
        label.textAlignment = .center
        label.font = UIFont(name: "Circe-Regular", size: 25)
        label.textColor = UIColor(rgb: 0x590190)
        return label
    }()
    
    var otherTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Other"
        label.textAlignment = .center
        label.font = UIFont(name: "Circe-Regular", size: 25)
        label.textColor = UIColor(rgb: 0x590190)
        return label
    }()
    
    var otherButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 0
        button.layer.borderColor = UIColor(rgb: 0xCE5EDF).cgColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfiger()
    }
    
    
    func viewConfiger() {
        self.iconImageView.image = UIImage(named: "gender")
        self.mainLabel.text = "Gender"
        self.currentIndexOfScreen = typeOfView.gender.rawValue + 1
        self.progressLabel.text = "\(100/RegView.numberOfScreens*currentIndexOfScreen!)% complete"

        setProgress(index: 3)
        
        backgroundView.addSubview(maleButton)
        backgroundView.addSubview(femaleButton)
        backgroundView.addSubview(otherButton)
        maleButton.addSubview(maleHatLabel)
        maleButton.addSubview(maleTextLabel)
        femaleButton.addSubview(femaleHatLabel)
        femaleButton.addSubview(femaleTextLabel)
        otherButton.addSubview(otherTextLabel)
        
        maleButton.addTarget(self, action: #selector(maleButtonPressed), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(femaleButtonPressed), for: .touchUpInside)
        otherButton.addTarget(self, action: #selector(otherButtonPressed), for: .touchUpInside)
        
        makeContsraint()
    }
    
    func makeContsraint() {
        maleButton.snp.makeConstraints() { (make) -> Void in
            make.top.equalToSuperview().offset(75)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(backgroundView.snp.centerX).offset(-20)
            make.height.equalTo(250)
        }
        
        maleHatLabel.snp.makeConstraints() { (make) -> Void in
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-25)
        }
        
        femaleButton.snp.makeConstraints() { (make) -> Void in
            make.top.equalToSuperview().offset(75)
            make.left.equalTo(backgroundView.snp.centerX).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(250)
        }
        
        femaleHatLabel.snp.makeConstraints() { (make) -> Void in
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-25)
        }
        
        otherButton.snp.makeConstraints() { (make) -> Void in
            make.top.equalTo(maleButton.snp.bottom).offset(20)
            make.height.equalTo(nextButton.snp.height)
            make.width.equalTo(nextButton.snp.width)
            make.centerX.equalToSuperview()
        }
        
        maleTextLabel.snp.makeConstraints() { (make) -> Void in
            make.bottom.equalToSuperview().offset(-25)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        femaleTextLabel.snp.makeConstraints() { (make) -> Void in
            make.bottom.equalToSuperview().offset(-25)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        otherTextLabel.snp.makeConstraints() { (make) -> Void in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    
    @objc func maleButtonPressed(sender: UIButton!) {
        maleButton.layer.borderWidth = 6
        femaleButton.layer.borderWidth = 0
        otherButton.layer.borderWidth = 0
        choosenGender = .male
    }
    
    @objc func femaleButtonPressed(sender: UIButton!) {
        maleButton.layer.borderWidth = 0
        femaleButton.layer.borderWidth = 6
        otherButton.layer.borderWidth = 0
        choosenGender = .female
    }
    
    @objc func otherButtonPressed(sender: UIButton!) {
        maleButton.layer.borderWidth = 0
        femaleButton.layer.borderWidth = 0
        otherButton.layer.borderWidth = 6
        choosenGender = .other
    }
    
    override func nextButtonPressed(sender: UIButton!) {
        presenter?.user.gender = choosenGender
        presenter?.inputGenderNext(from: self)
    }
    
}
