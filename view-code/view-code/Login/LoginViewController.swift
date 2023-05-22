//
//  LoginViewController.swift
//  view-code
//
//  Created by Livia Keller on 21/05/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginView: LoginView?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func loadView() {
        self.loginView = LoginView()
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView?.configTextFieldDelegate(self)
        loginView?.delegate(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        loginView?.validaTextFields()
    }
}

extension LoginViewController: LoginViewProtocol {
    func actionLoginButton() {
        
    }
    
    func actionRegisterButton() {
        let vc: RegisterViewController = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
