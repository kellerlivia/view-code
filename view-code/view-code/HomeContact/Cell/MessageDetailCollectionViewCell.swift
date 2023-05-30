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
            imageView.widthAnchor.constraint(equalToConstant: 55),
            
            userName.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            userName.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
            
        ])
    }
    
    public func setupViewContact(contact: Contact) {
        self.setUserName(userName: contact.name ?? "")
    }
    
    public func setupViewConversation(conversation: Conversation) {
        setUserNameAttributedText(conversation)
    }
    
    public func setUserNameAttributedText (_ conversation: Conversation) {
        let attributText = NSMutableAttributedString(string: "\(conversation.name ?? "")", attributes: [NSAttributedString.Key.font : UIFont(name: "Footnote", size: 16) ?? UIFont(), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        attributText.append(NSMutableAttributedString(string: "\n\(conversation.lastMessage ?? "")", attributes: [NSAttributedString.Key.font : UIFont(name: "Footnote", size: 14) ?? UIFont(), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        self.userName.attributedText = attributText
    }
    
    public func setUserName(userName: String) {
        let attributText = NSMutableAttributedString(string: userName, attributes: [NSAttributedString.Key.font : UIFont(name: "Footnote", size: 16) ?? UIFont(), NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.userName.attributedText = attributText
    }
}
