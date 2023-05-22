//
//  RegisterViewController.swift
//  view-code
//
//  Created by Livia Keller on 22/05/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var registerView: RegisterView?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func loadView() {
        self.registerView = RegisterView()
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView?.configTextFieldDelegate(self)
        registerView?.delegate(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.registerView?.validaTextFields()
    }
}

extension RegisterViewController: RegisterViewProtocol {
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionRegisterButton() {
        
    }
}
