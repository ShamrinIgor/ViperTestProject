//
// Created by VIPER
// Copyright (c) 2020 VIPER. All rights reserved.
//

import Foundation

class RegViewInteractor: RegViewInteractorInputProtocol
{
    weak var presenter: RegViewInteractorOutputProtocol?
    var APIDataManager: RegViewAPIDataManagerInputProtocol?
    var localDatamanager: RegViewLocalDataManagerInputProtocol?
    
    init() {}
}