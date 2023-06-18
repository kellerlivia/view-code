//
//  ChatView.swift
//  view-code
//
//  Created by Livia Keller on 17/06/23.
//

import UIKit
import AVFoundation

protocol ChatViewScreenProtocol:AnyObject {
    func actionPushMessage()
}

class ChatView: UIView {
    
    weak private var delegate: ChatViewScreenProtocol?
    
    public func delegate(delegate: ChatViewScreenProtocol?){
        self.delegate = delegate
    }
    
    var bottomContraint:NSLayoutConstraint?
    var player:AVAudioPlayer?
    
    lazy var chatNavView: ChatNavigationView = {
        let view = ChatNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var messageInputView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var messageBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.appLight
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = CustomColor.appPink
        button.layer.cornerRadius = 22.5
        button.layer.shadowColor = CustomColor.appPink.cgColor
        button.layer.shadowRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowOpacity = 0.3
        button.addTarget(self, action: #selector(self.sendButtonPressed), for: .touchUpInside)
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    lazy var inputMessageTextField:UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Digite aqui"
        textField.font = UIFont(name: CustomFont.poppinsSemiBold, size: 14)
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var tableView:UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(IncomingTextMessageTableViewCell.self, forCellReuseIdentifier: IncomingTextMessageTableViewCell.identifier)
        table.register(OutgoingTextMessageTableViewCell.self, forCellReuseIdentifier: OutgoingTextMessageTableViewCell.identifier)
        table.backgroundColor = .clear
        table.transform = CGAffineTransform(scaleX: 1, y: -1)
        table.separatorStyle = .none
        table.tableFooterView = UIView()
        return table
    }()
    
    public func configTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource){
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }
    
    public func reloadTableView(){
        self.tableView.reloadData()
    }
    
    func configNavView(controller: ChatViewController) {
        self.chatNavView.controller = controller
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configSuperView()
        configConstrints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        inputMessageTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        bottomContraint = NSLayoutConstraint(item: messageInputView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        
        addConstraint(bottomContraint ?? NSLayoutConstraint())
        sendButton.isEnabled = false
        sendButton.layer.opacity = 0.4
        sendButton.transform = .init(scaleX: 0.8, y: 0.8)
        inputMessageTextField.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func sendButtonPressed(){
        sendButton.touchAnimation(s: sendButton)
//        playSound()
        self.delegate?.actionPushMessage()
        startPushMessage()
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "send", withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            guard let player = self.player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    public func startPushMessage(){
        self.inputMessageTextField.text = ""
        self.sendButton.isEnabled = false
        self.sendButton.layer.opacity = 0.4
        self.sendButton.transform = .init(scaleX: 0.8, y: 0.8)
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification){
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            self.bottomContraint?.constant = isKeyboardShowing ? -keyboardHeight : 0
            
            self.tableView.center.y = isKeyboardShowing ? self.tableView.center.y-keyboardHeight : self.tableView.center.y+keyboardHeight
            
            UIView.animate(withDuration:0.1, delay: 0 , options: .curveEaseOut , animations: {
                self.layoutIfNeeded()
            } , completion: {(completed) in
                //config
            })
        }
    }
    
    private func configSuperView() {
        addSubview(tableView)
        addSubview(chatNavView)
        addSubview(messageInputView)
        messageInputView.addSubview(messageBar)
        messageBar.addSubview(sendButton)
        messageBar.addSubview(inputMessageTextField)
    }
    
    private func configConstrints() {
        NSLayoutConstraint.activate([
            
            chatNavView.topAnchor.constraint(equalTo: topAnchor),
            chatNavView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chatNavView.trailingAnchor.constraint(equalTo: trailingAnchor),
            chatNavView.heightAnchor.constraint(equalToConstant: 140),
            
            tableView.topAnchor.constraint(equalTo: chatNavView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageInputView.topAnchor),
            
            messageInputView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            messageInputView.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageInputView.trailingAnchor.constraint(equalTo: trailingAnchor),
            messageInputView.heightAnchor.constraint(equalToConstant: 80),
            
            messageBar.leadingAnchor.constraint(equalTo: messageInputView.leadingAnchor,constant: 20),
            messageBar.trailingAnchor.constraint(equalTo: messageInputView.trailingAnchor,constant: -20),
            messageBar.heightAnchor.constraint(equalToConstant: 55),
            messageBar.centerYAnchor.constraint(equalTo: messageInputView.centerYAnchor),
            
            sendButton.trailingAnchor.constraint(equalTo: messageBar.trailingAnchor, constant: -15),
            sendButton.heightAnchor.constraint(equalToConstant: 55),
            sendButton.widthAnchor.constraint(equalToConstant: 55),
            sendButton.bottomAnchor.constraint(equalTo: messageBar.bottomAnchor, constant: -10),
            
            inputMessageTextField.leadingAnchor.constraint(equalTo: messageBar.leadingAnchor,constant: 20),
            inputMessageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor,constant: -5),
            inputMessageTextField.heightAnchor.constraint(equalToConstant: 45),
            inputMessageTextField.centerYAnchor.constraint(equalTo: messageBar.centerYAnchor)
            
        ])
    }
}

extension ChatView: UITextFieldDelegate{
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if self.inputMessageTextField.text == "" {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.sendButton.isEnabled = false
                self.sendButton.layer.opacity = 0.4
                self.sendButton.transform = .init(scaleX: 0.8, y: 0.8)
            }, completion: { _ in
            })
        }
        else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.sendButton.isEnabled = true
                self.sendButton.layer.opacity = 1
                self.sendButton.transform = .identity
            }, completion: { _ in
            })
        }
    }
}
