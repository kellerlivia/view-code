//
//  HomeContactViewController.swift
//  view-code
//
//  Created by Livia Keller on 29/05/23.
//

import UIKit
import Firebase

class HomeContactViewController: UIViewController {
    
    var homeContactView: HomeContactView?
    var auth: Auth?
    var bd: Firestore?
    var idUserLogado: String?
    var emailUserLogado: String?
    var alert: Alert?
    var viewContact: Bool?
    
    override func loadView() {
        self.homeContactView = HomeContactView()
        view = homeContactView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemGray4
        configHomeView()
        configCollectioView()
        configAlert()
    }
    
    private func configHomeView() {
        homeContactView?.navView.delegate(self)
    }
    
    private func configCollectioView () {
        homeContactView?.configCollectionViewProtocols(delegate: self, dataSource: self)
    }
    
    private func configAlert() {
        alert = Alert(controller: self)
    }
}

extension HomeContactViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

extension HomeContactViewController: NavViewProtocol {
    func typeViewMessage(type: TypeConversationOrContact) {
        switch type {
        case .contact:
            self.viewContact = true
        case .conversation:
            self.viewContact = false
        }
    }
}
