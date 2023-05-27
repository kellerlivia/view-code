//
//  UserDetailTableViewCell.swift
//  view-code
//
//  Created by Livia Keller on 24/05/23.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {
    
    static let identifier: String = "UserDetailTableViewCell"
    
    lazy var userDetailView: UserDetailView = {
        let view = UserDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubView()
        configConstrints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubView() {
        contentView.addSubview(userDetailView)
    }
    
    public func configCell(data: UserData) {
        userDetailView.nameLabel.text = data.name
        userDetailView.userImageView.image = UIImage(systemName: data.nameImage)
        userDetailView.userImageView.tintColor = .black
    }
    
    private func configConstrints() {
        NSLayoutConstraint.activate([
            
            userDetailView.topAnchor.constraint(equalTo: self.topAnchor),
            userDetailView.leftAnchor.constraint(equalTo: self.leftAnchor),
            userDetailView.rightAnchor.constraint(equalTo: self.rightAnchor),
            userDetailView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
}
