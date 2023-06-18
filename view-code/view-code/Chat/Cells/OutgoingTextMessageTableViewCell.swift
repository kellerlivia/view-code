//
//  OutgoingTextMessageTableViewCell.swift
//  view-code
//
//  Created by Livia Keller on 18/06/23.
//

import UIKit

class OutgoingTextMessageTableViewCell: UITableViewCell {

    static let identifier:String = "OutgoingTextMessageTableViewCell"
    
    lazy var myMessageView:UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.appPurple
        view.layer.cornerRadius = 20
        view.layer.maskedCorners =  [.layerMinXMaxYCorner, .layerMinXMinYCorner , .layerMaxXMinYCorner]
        return view
    }()
    
    lazy var messageTextLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: CustomFont.poppinsSemiBold, size: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configSuperView()
        self.configConstrints()
    }
    
    func configSuperView(){
        addSubview(myMessageView)
        myMessageView.addSubview(messageTextLabel)
        self.isSelected = false
    }
    
    func configConstrints(){
        NSLayoutConstraint.activate([
            
            myMessageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            myMessageView.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            myMessageView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            messageTextLabel.leadingAnchor.constraint(equalTo: myMessageView.leadingAnchor,constant: 15),
            messageTextLabel.topAnchor.constraint(equalTo: myMessageView.topAnchor,constant: 15),
            messageTextLabel.bottomAnchor.constraint(equalTo: myMessageView.bottomAnchor,constant: -15),
            messageTextLabel.trailingAnchor.constraint(equalTo: myMessageView.trailingAnchor,constant: -15),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(message:Message?){
        self.messageTextLabel.text = message?.text ?? ""
    }
}
