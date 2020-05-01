//
// Created by VIPER
// Copyright (c) 2020 VIPER. All rights reserved.
//

import Foundation

class RegPresenter: RegViewPresenterProtocol
{
    weak var view: RegViewProtocol?
    var wireFrame: RegViewWireFrameProtocol?
    var user = User()
    
    init() {}
    
    func inputNameNext(from: RegViewProtocol) {
        wireFrame?.presentRegBirthdayScreen(from: from)
        print(user)
    }
    
    func inputBirthdayNext(from: RegViewProtocol) {
        wireFrame?.presentRegGenderScreen(from: from)
        print(user)
    }
    
    func inputGenderNext(from: RegViewProtocol) {
        wireFrame?.presentRegPhotoScreen(from: from)
        print(user)
    }
    
    func inputPhotoNext(from: RegViewProtocol){
        print(user)
    }
}
