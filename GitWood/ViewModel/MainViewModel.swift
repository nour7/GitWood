//
//  MainViewModel.swift
//  GitWood
//
//  Created by Nour on 23/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation

protocol ViewModel {}

struct MainViewModel<S: StorageProtocol>: ViewModel {
    let storage: S
}
