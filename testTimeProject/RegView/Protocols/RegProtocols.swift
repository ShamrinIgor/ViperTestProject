//
// Created by VIPER
// Copyright (c) 2020 VIPER. All rights reserved.
//

import Foundation
import UIKit

protocol RegViewProtocol: RegView
{
    var presenter: RegViewPresenterProtocol? { get set }
    func viewConfiger()
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol RegViewWireFrameProtocol: class
{
    static func presentRegViewModule() -> UIViewController
    func presentRegBirthdayScreen(from view: RegViewProtocol)
    func presentRegGenderScreen(from view : RegViewProtocol)
    func presentRegPhotoScreen(from view : RegViewProtocol)
    
    /**
     * Add here your methods for communication PRESENTER -> WIREFRAME
     */
}

protocol RegViewPresenterProtocol: class
{
    var view: RegViewProtocol? { get set }
    var wireFrame: RegViewWireFrameProtocol? { get set }
    var user: User {get set}
    func inputNameNext(from: RegViewProtocol)
    func inputBirthdayNext(from: RegViewProtocol)
    func inputGenderNext(from: RegViewProtocol)
    func inputPhotoNext(from: RegViewProtocol)
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
}


