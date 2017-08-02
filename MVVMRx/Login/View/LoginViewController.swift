//
//  LoginViewController.swift
//  MVVMRx
//
//  Created by Kam Hei Siu on 2/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passswordTxtField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    let disposeBag = DisposeBag()
    
    var loginViewModel: LoginViewModel! = LoginViewModelFromLogin()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUsernameTF()
        setupPWTF()
        setupLoginBtn()
    }
    
    func setupUsernameTF() {
        usernameTxtField.layer.cornerRadius = usernameTxtField.frame.height / 2
        usernameTxtField.rx.text.asObservable()
            .map{ $0 ?? "" }
            .bind(to: loginViewModel.username)
            .addDisposableTo(disposeBag)
    }
    
    func setupPWTF() {
        passswordTxtField.layer.cornerRadius = passswordTxtField.frame.height / 2
        passswordTxtField.rx.text.asObservable()
            .map{ $0 ?? "" }
            .bind(to: loginViewModel.password)
            .addDisposableTo(disposeBag)
    }
    
    func setupLoginBtn() {
        loginBtn.layer.cornerRadius = loginBtn.frame.height / 2
        loginViewModel
            .isValid
            .bind(to: loginBtn.rx.isEnabled)
            .addDisposableTo(disposeBag)
    }

}

