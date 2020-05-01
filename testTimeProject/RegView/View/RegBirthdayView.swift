import Foundation
import UIKit
import SnapKit


class RegBirthdayView: RegView, RegViewProtocol {
        
    var presenter: RegViewPresenterProtocol?
    
    var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfiger()
    }
    
    func viewConfiger() {
        self.iconImageView.image = UIImage(named: "calendar")
        self.mainLabel.text = "Birthday"
        self.currentIndexOfScreen = typeOfView.birthday.rawValue + 1
        self.progressLabel.text = "\(100/RegView.numberOfScreens*currentIndexOfScreen!)% complete"
        
        setProgress(index: 2)
        
        backgroundView.addSubview(datePicker)
        makeConstaints()
    }
    
    func makeConstaints() {
        datePicker.snp.makeConstraints() { (make) -> Void in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
        }
    }
    
    override func nextButtonPressed(sender: UIButton!) {
        presenter?.user.birthday = datePicker.date
        presenter?.inputBirthdayNext(from: self)
    }
}
