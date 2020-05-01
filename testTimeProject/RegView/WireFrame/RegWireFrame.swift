//
// Created by VIPER
// Copyright (c) 2020 VIPER. All rights reserved.
//

import Foundation
import UIKit

class RegWireFrame: RegViewWireFrameProtocol {
    class func presentRegViewModule() -> UIViewController {
        let initialVC = RegNameView()
        let navController = UINavigationController(rootViewController: initialVC)
        if let view = navController.children.first as? RegNameView {
            let presenter: RegViewPresenterProtocol = RegPresenter()
            let wireFrame: RegViewWireFrameProtocol = RegWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            
            return navController
        }
        return UIViewController()
    }
    
    func presentRegBirthdayScreen(from view: RegViewProtocol) {
        let birthVC = RegBirthdayView()
        birthVC.presenter = view.presenter
        view.navigationController?.pushViewController(birthVC, animated: true)
    }
    
    func presentRegGenderScreen(from view : RegViewProtocol) {
        let genderVC = RegGenderView()
        genderVC.presenter = view.presenter
        view.navigationController?.pushViewController(genderVC, animated: true)
    }
    
    func presentRegPhotoScreen(from view : RegViewProtocol) {
        let photoVC = RegPhotoView()
        photoVC.presenter = view.presenter
        view.navigationController?.pushViewController(photoVC, animated: true)
    }
}
