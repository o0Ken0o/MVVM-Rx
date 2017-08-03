//
//  LoginViewModel.swift
//  MVVMRx
//
//  Created by Kam Hei Siu on 2/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginViewModel {
    var username: Variable<String> { set get }
    var usernamePlaceHolder: String { get }
    var password: Variable<String> { set get }
    var passwordPlaceHolder: String { get }
    var isValid: Observable<Bool> { get }
    func login()
}
