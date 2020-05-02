import Foundation
import UIKit

class RegNameView: RegView, RegViewProtocol {
    
    var presenter: RegViewPresenterProtocol?
    
    var backgroundIsUp = false
    var backgroundOffset: CGFloat = 0.0
    
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
    
    override func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else{return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else{return}
        let keyboardFrame = keyboardSize.cgRectValue.height
        
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        
        if !self.keyboardIsOpen {
            self.nextButton.frame.origin.y -= (keyboardFrame - bottomPadding!)
            self.keyboardIsOpen = true
        }

        if nextButton.frame.minY < nameTextField.frame.maxY + 200 {
            self.backgroundOffset = backgroundView.frame.minY - progressBarView.frame.minY + 20
            backgroundView.frame.origin.y -= backgroundView.frame.minY - progressBarView.frame.minY + 20
            backgroundIsUp = true
        }
        
    }
    
    override   func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo else{return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else{return}
        let keyboardFrame = keyboardSize.cgRectValue.height
        
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom
        
        if self.keyboardIsOpen {
            self.nextButton.frame.origin.y += (keyboardFrame - bottomPadding!)
            self.keyboardIsOpen = false
        }
        
        if self.backgroundIsUp {
            backgroundView.frame.origin.y += backgroundOffset
            backgroundIsUp = false
        }
        
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

//MARK: Keyboard handler


