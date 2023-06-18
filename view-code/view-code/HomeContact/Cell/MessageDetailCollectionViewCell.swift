//
//  MessageDetailCollectionViewCell.swift
//  view-code
//
//  Created by Livia Keller on 30/05/23.
//

import UIKit

class MessageDetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "MessageDetailCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person.fill")
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15)
        label.text = "aaaa"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(userName)
        addSubview(messageLabel)
        configConstrints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configConstrints() {
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 55),
            imageView.heightAnchor.constraint(equalToConstant: 55),
        
            userName.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            userName.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            messageLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            messageLabel.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 5),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
            
        ])
    }
    
//    public func setupViewContact(contact: String) {
//        self.setUserName(userName: contact )
//    }
//
//    public func setupViewConversation(conversation: Conversation) {
//        setUserNameAttributedText(conversation)
//    }
//
//    func setUserNameAttributedText(_ conversation: Conversation) {
//        let attributedText = NSMutableAttributedString(string:"\(conversation.name ?? "")", attributes:[NSAttributedString.Key.font: UIFont(name: CustomFont.poppinsMedium, size: 16) ?? UIFont(),NSAttributedString.Key.foregroundColor: UIColor.darkGray])
//
//        attributedText.append(NSAttributedString(string: "\n\(conversation.lastMessage ?? "")", attributes:[NSAttributedString.Key.font: UIFont(name: CustomFont.poppinsMedium, size: 14) ?? UIFont(), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
//
//        self.userName.attributedText = attributedText
//    }
//
//    func setUserName(userName: String) {
//        let attributText = NSMutableAttributedString(string: userName, attributes: [NSAttributedString.Key.font : UIFont(name: CustomFont.poppinsMedium, size: 16) ?? UIFont(), NSAttributedString.Key.foregroundColor:UIColor.darkGray])
//        self.userName.attributedText = attributText
//    }
}
