//
//  ChatNavigationView.swift
//  view-code
//
//  Created by Livia Keller on 17/06/23.
//

import UIKit

class ChatNavigationView: UIView {
    
    var controller: ChatViewController? {
        didSet {
            self.backButton.addTarget(controller, action: #selector(ChatViewController.tappedBackButton), for: .touchUpInside)
        }
    }
    
    lazy var navBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.05).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        return view
    }()
    
    lazy var navBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var searchBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = "digite aqui"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var customImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person.circle")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 26
        image.tintColor = .systemGray
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSuperView()
        configConstrints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSuperView() {
        addSubview(navBackgroundView)
        navBackgroundView.addSubview(navBar)
        navBar.addSubview(backButton)
        navBar.addSubview(customImage)
        navBar.addSubview(searchBar)
        searchBar.addSubview(searchLabel)
        searchBar.addSubview(searchButton)
    }

    private func configConstrints() {
        NSLayoutConstraint.activate([
            
            navBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            navBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            navBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 30),
            backButton.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            
            customImage.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 20),
            customImage.heightAnchor.constraint(equalToConstant: 55),
            customImage.widthAnchor.constraint(equalToConstant: 55),
            customImage.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            
            searchBar.leadingAnchor.constraint(equalTo: customImage.trailingAnchor, constant: 20),
            searchBar.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            searchBar.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            searchLabel.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 20),
            searchLabel.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            
            searchButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -20),
            searchButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 20),
            searchButton.widthAnchor.constraint(equalToConstant: 20),
            
        ])
    }
}
