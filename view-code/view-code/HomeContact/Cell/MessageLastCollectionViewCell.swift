//
//  MessageLastCollectionViewCell.swift
//  view-code
//
//  Created by Livia Keller on 30/05/23.
//

import UIKit

class MessageLastCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "MessageLastCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = false
        image.image = UIImage(systemName: "person.badge.plus")
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "adicionar novo contato"
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(userName)
        configConstrints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configConstrints() {
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 55),
            imageView.widthAnchor.constraint(equalToConstant: 45),
            
            userName.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            userName.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
            
        ])
    }
}

