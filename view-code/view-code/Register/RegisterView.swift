//
//  RegisterView.swift
//  view-code
//
//  Created by Livia Keller on 22/05/23.
//

import UIKit

protocol RegisterViewProtocol: AnyObject {
    func actionBackButton()
    func actionRegisterButton()
}

class RegisterView: UIView {
    
    private weak var delegate: RegisterViewProtocol?
    
    func delegate(_ delegate: RegisterViewProtocol?) {
        self.delegate = delegate
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrowshape.turn.up.left.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person.fill")
        image.tintColor = .white
        return image
    }()
    
    lazy var nameTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "digite seu nome"
        text.keyboardType = .default
        text.backgroundColor = .white
        text.autocorrectionType = .no
        text.autocapitalizationType = .none
        text.borderStyle = .roundedRect
        text.textColor = .black
        return text
    }()
    
    lazy var emailTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "digite seu email"
        text.keyboardType = .emailAddress
        text.backgroundColor = .white
        text.autocorrectionType = .no
        text.borderStyle = .roundedRect
        text.autocapitalizationType = .none
        text.textColor = .black
        return text
    }()
    
    lazy var passwordTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "digite sua senha"
        text.keyboardType = .default
        text.isSecureTextEntry = true
        text.backgroundColor = .white
        text.autocorrectionType = .no
        text.borderStyle = .roundedRect
        text.textColor = .black
        return text
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("acessar", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitleColor(.systemPink, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemPink
        configSuperView()
        configConstrints()
        configButtonEnable(false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSuperView() {
        self.addSubview(backButton)
        self.addSubview(userImage)
        self.addSubview(nameTextField)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(registerButton)
    }
    
    public func configTextFieldDelegate(_ delegate: UITextFieldDelegate) {
        nameTextField.delegate = delegate
        emailTextField.delegate = delegate
        passwordTextField.delegate = delegate
    }
    
    public func validaTextFields() {
        let name: String = nameTextField.text ?? ""
        let email: String = emailTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        
        if !name.isEmpty && !email.isEmpty && !password.isEmpty {
            configButtonEnable(true)
        } else {
            configButtonEnable(false)
        }
    }
    
    public func configButtonEnable(_ enable: Bool) {
        if enable {
            registerButton.setTitleColor(.systemPink, for: .normal)
            registerButton.isEnabled = true
        } else {
            registerButton.setTitleColor(.lightGray, for: .normal)
            registerButton.isEnabled = false
        }
    }
    
    public func getName() -> String {
        return nameTextField.text ?? ""
    }
    
    public func getEmail() -> String {
        return emailTextField.text ?? ""
    }
    
    public func getPassword() -> String {
        return passwordTextField.text ?? ""
    }
    
    @objc private func tappedBackButton() {
        self.delegate?.actionBackButton()
    }
    
    @objc private func tappedRegisterButton() {
        self.delegate?.actionRegisterButton()
    }
    
    private func configConstrints() {
        NSLayoutConstraint.activate([
            
            userImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            userImage.heightAnchor.constraint(equalToConstant: 140),
            userImage.widthAnchor.constraint(equalToConstant: 150),
            userImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            backButton.topAnchor.constraint(equalTo: userImage.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            nameTextField.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 40),
            nameTextField.heightAnchor.constraint(equalToConstant: 45),
            nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 35),
            registerButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            registerButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
        ])
    }
}
