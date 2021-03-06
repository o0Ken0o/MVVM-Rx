//
//  LoginViewModelFromLogin.swift
//  MVVMRx
//
//  Created by Kam Hei Siu on 2/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import Foundation
import RxSwift

struct LoginViewModelFromLogin: LoginViewModel {
    var username: Variable<String> = Variable("")
    var usernamePlaceHolder: String {
        return "Enter your username"
    }
    
    var password: Variable<String> = Variable("")
    var passwordPlaceHolder: String {
        return "Enter your password"
    }
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(username.asObservable(), password.asObservable()) {
            return $0.characters.count > 5 && $1.characters.count > 5
        }
    }
    
    var isLoginSuccessful: Variable<Bool> = Variable<Bool>(false)
    func login() {
        isLoginSuccessful.value = true
    }
}
