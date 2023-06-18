//
//  IncomingTextMessageTableViewCell.swift
//  view-code
//
//  Created by Livia Keller on 18/06/23.
//

import UIKit

class IncomingTextMessageTableViewCell: UITableViewCell {
    
    static let identifier:String = "IncomingTextMessageTableViewCell"
    
    lazy var contactMessage: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.06)
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner , .layerMaxXMinYCorner]
        return view
    }()
    
    lazy var messageTextLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configSuperView()
        self.configConstrints()
    }
    
    func configSuperView() {
        addSubview(contactMessage)
        contactMessage.addSubview(messageTextLabel)
        self.isSelected = false
    }
    
    func configConstrints(){
        NSLayoutConstraint.activate([
            
            contactMessage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            contactMessage.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            contactMessage.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            messageTextLabel.leadingAnchor.constraint(equalTo: contactMessage.leadingAnchor,constant: 15),
            messageTextLabel.topAnchor.constraint(equalTo: contactMessage.topAnchor,constant: 15),
            messageTextLabel.bottomAnchor.constraint(equalTo: contactMessage.bottomAnchor,constant: -15),
            messageTextLabel.trailingAnchor.constraint(equalTo: contactMessage.trailingAnchor,constant: -15),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(message: Message?) {
        self.messageTextLabel.text = message?.text ?? ""
    }
}

