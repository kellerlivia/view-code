//
//  SportCollectionViewCell.swift
//  view-code
//
//  Created by Livia Keller on 27/05/23.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "SportCollectionViewCell"
    let sportCollectionCellView: SportCollectionCellView = SportCollectionCellView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSuperView()
        configConstrints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configSuperView() {
        sportCollectionCellView.layer.borderWidth = 6.0
        sportCollectionCellView.layer.borderColor = UIColor.black.cgColor
        sportCollectionCellView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(sportCollectionCellView)
    }
    
    public func setUpCell(data: Sport) {
        sportCollectionCellView.imageView.image = UIImage(systemName: data.nameImage)
        sportCollectionCellView.sportName.text = data.name
    }
    
    private func configConstrints() {
        NSLayoutConstraint.activate([
            
            sportCollectionCellView.topAnchor.constraint(equalTo: self.topAnchor),
            sportCollectionCellView.leftAnchor.constraint(equalTo: self.leftAnchor),
            sportCollectionCellView.rightAnchor.constraint(equalTo: self.rightAnchor),
            sportCollectionCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
}
