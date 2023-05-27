//
//  SportCollectionCellView.swift
//  view-code
//
//  Created by Livia Keller on 27/05/23.
//

import UIKit

class SportCollectionCellView: UIView {
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var sportName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        return label
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
        self.addSubview(imageView)
        self.addSubview(sportName)
    }
    
    private func configConstrints() {
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: sportName.topAnchor, constant: -10),
            
            sportName.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            sportName.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            sportName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            sportName.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
}

