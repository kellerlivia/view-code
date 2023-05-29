//
//  LoginViewController.swift
//  view-code
//
//  Created by Livia Keller on 21/05/23.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var auth: Auth?
    var alert: Alert?
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
        self.auth = Auth.auth()
        self.alert = Alert(controller: self)
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
        
        guard let login = self.loginView else { return }
        
        self.auth?.signIn(withEmail: login.getEmail(), password: login.getPassword(), completion: { (usuario, error) in
            if error != nil {
                self.alert?.getAlert(title: "atenção", message: "dados incorretos, tente novamente!!")
            } else {
                if usuario == nil {
                    self.alert?.getAlert(title: "atenção", message: "tivemos um erro inesperado, tente novamente mais tarde!!")
                } else {
                    let vc: HomeViewController = HomeViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        })
    }
    
    func actionRegisterButton() {
        let vc: RegisterViewController = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
