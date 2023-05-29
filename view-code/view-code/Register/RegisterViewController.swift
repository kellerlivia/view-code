//
//  RegisterViewController.swift
//  view-code
//
//  Created by Livia Keller on 22/05/23.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    var auth: Auth?
    var alert: Alert?
    var firestore: Firestore?
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
        self.auth = Auth.auth()
        firestore = Firestore.firestore()
        self.alert = Alert(controller: self)
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
        guard let register = self.registerView else { return }
        
        self.auth?.createUser(withEmail: register.getEmail(), password: register.getPassword(), completion: { (result, error) in
            if error != nil {
                self.alert?.getAlert(title: "atenção", message: "erro ao cadastrar, verifique os dados e tente novamente")
            } else {
                
                if let idUsuario = result?.user.uid {
                    self.firestore?.collection("usuarios").document(idUsuario).setData([
                        "nome" : self.registerView?.getName() ?? "",
                        "email" : self.registerView?.getEmail() ?? "",
                        "id" : idUsuario
                    ])
                }
                
                self.alert?.getAlert(title: "parabens", message: "usuario cadastrado com sucesso", completion: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
        })
    }
}
