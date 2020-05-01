import Foundation
import UIKit

class RegNameView: RegView, RegViewProtocol {
    
    var presenter: RegViewPresenterProtocol?
    
    var nameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .gray
        textField.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        textField.textAlignment = .center
        textField.placeholder = "Name"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        viewConfiger()
    }
    
    func viewConfiger() {
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.tintColor = .clear
        self.iconImageView.image = UIImage(named: "chat")
        self.mainLabel.text = "Your name"
        self.mainLabel.sizeToFit()
        self.currentIndexOfScreen = typeOfView.inputName.rawValue + 1
        self.progressLabel.text = "\(100/RegView.numberOfScreens*currentIndexOfScreen!)% complete"
        nameTextField.frame = CGRect(x: 0, y: backgroundView.frame.minY + 50, width: backgroundView.frame.width, height: 50.0)
        backgroundView.addSubview(nameTextField)
        
       setProgress(index: 1)
        
        nextButton.isEnabled = false
        nextButton.alpha = 0.3
        arrowImageView.isHidden = true
    }
    
    override func nextButtonPressed(sender: UIButton!) {
        print("Next button pressed from NameView")
        handleTap()
        presenter?.user.name = nameTextField.text
        presenter?.inputNameNext(from: self)
    }
    
   
}


 //MARK: TextFieldDelegate
extension RegNameView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nameText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if (nameText.isEmpty) {
            nextButton.isEnabled = false
            nextButton.alpha = 0.3
            arrowImageView.isHidden = true
        } else {
            nextButton.isEnabled = true
            nextButton.alpha = 1.0
            arrowImageView.isHidden = false
        }
        
        return true
    }
}
