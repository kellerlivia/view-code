//
//  HomeView.swift
//  view-code
//
//  Created by Livia Keller on 24/05/23.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func actionChatButton()
}

class HomeView: UIView {
    
    private weak var delegate: HomeViewProtocol?
    
    func delegate(_ delegate: HomeViewProtocol?) {
        self.delegate = delegate
    }
    
    lazy var chatButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("acessar", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitleColor(.systemPink, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(tappedChatButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func tappedChatButton() {
        self.delegate?.actionChatButton()
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(UserDetailTableViewCell.self, forCellReuseIdentifier: UserDetailTableViewCell.identifier)
        tableView.register(SportTableViewCell.self, forCellReuseIdentifier: SportTableViewCell.identifier)
        return tableView
    }()
    
    public func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemPink
        configSuperView()
        configConstrints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSuperView() {
        self.addSubview(chatButton)
        self.addSubview(tableView)
    }
    
    private func configConstrints() {
        NSLayoutConstraint.activate([
            
            chatButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            chatButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            chatButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            tableView.topAnchor.constraint(equalTo: chatButton.bottomAnchor, constant: 30),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
}

