//
//  SportTableViewCell.swift
//  view-code
//
//  Created by Livia Keller on 27/05/23.
//

import UIKit

class SportTableViewCell: UITableViewCell {
    
    static let identifier: String = "SportTableViewCell"
    var sportTableViewCellView: SportTableViewCellView = SportTableViewCellView()
    
    var data: [Sport] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configSuperView()
        configConstrints()
        sportTableViewCellView.configCollectionViewProtocols(delegate: self, dataSource: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSuperView() {
        sportTableViewCellView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sportTableViewCellView)
    }
    
    public func dataCollection(data: [Sport]) {
        self.data = data
    }
    
    private func configConstrints() {
        NSLayoutConstraint.activate([
            
            sportTableViewCellView.topAnchor.constraint(equalTo: self.topAnchor),
            sportTableViewCellView.leftAnchor.constraint(equalTo: self.leftAnchor),
            sportTableViewCellView.rightAnchor.constraint(equalTo: self.rightAnchor),
            sportTableViewCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
}

extension SportTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SportCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: SportCollectionViewCell.identifier, for: indexPath) as? SportCollectionViewCell
        cell?.setUpCell(data: self.data[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 90)
    }
}
