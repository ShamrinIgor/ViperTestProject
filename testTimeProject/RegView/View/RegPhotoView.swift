import Foundation
import UIKit
import SnapKit

class RegPhotoView: RegView, RegViewProtocol {
    var presenter: RegViewPresenterProtocol?
    
    var photoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.contentMode = .scaleAspectFit
        button.layer.cornerRadius = 30
        return button
    }()
    
    var cameraImageView: UIImageView = {
        let view = UIImageView(image:  UIImage(named: "camera"))
        view.contentMode = .scaleAspectFit
        view.tintColor = UIColor(rgb: 0x590190)
        return view
    }()
    
    private var imagePickerController = UIImagePickerController()
    var selectedImage = #imageLiteral(resourceName: "avatar-placeholder")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        viewConfiger()
    }
    
    func viewConfiger() {
        setProgress(index: 4)
        
        self.iconImageView.image = UIImage(named: "camera")
        self.mainLabel.text = "Profile photo"
        self.currentIndexOfScreen = typeOfView.profilePhoto.rawValue + 1
        self.progressLabel.text = "\(100/RegView.numberOfScreens*currentIndexOfScreen!)% complete"
        
        backgroundView.addSubview(photoButton)
        photoButton.addSubview(cameraImageView)
        
        photoButton.addTarget(self, action: #selector(photoButtonPressed), for: .touchUpInside)
        
        makeConstraints()
    }
    
    func makeConstraints() {
        photoButton.snp.makeConstraints() { (make) -> Void in
            make.top.equalToSuperview().offset(75)
            make.left.equalToSuperview().offset(85)
            make.right.equalToSuperview().offset(-85)
            make.height.equalTo(350)
        }
        
        cameraImageView.snp.makeConstraints() { (make) -> Void in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
    }
    
    @objc func photoButtonPressed(sender: UIButton!) {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    override func nextButtonPressed(sender: UIButton!) {
        presenter?.user.photo = selectedImage
        presenter?.inputPhotoNext(from: self)
    }
    
}

//MARK: UIImagePickerControllerDelegate
extension RegPhotoView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return }
        selectedImage = image
        self.photoButton.setBackgroundImage(selectedImage, for: .normal)
        self.cameraImageView.isHidden = true
        do {
            imagePickerController.dismiss(animated: true, completion: nil)
        }
    }
}
