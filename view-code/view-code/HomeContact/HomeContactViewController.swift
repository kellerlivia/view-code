//
//  HomeContactViewController.swift
//  view-code
//
//  Created by Livia Keller on 29/05/23.
//

import UIKit
import Firebase


class HomeContactViewController: UIViewController {
    
    var auth: Auth?
    var db: Firestore?
    var idUsuarioLogado: String?
    
    var viewContact: Bool?
    var emailUsuarioLogado: String?
    var alert: Alert?
    
    var homeView: HomeContactView?
    
    var contato: ContactController?
    var listContact: [String] = []
    var listaConversas: [Conversation] = []
    var conversasListener: ListenerRegistration?
    
    override func loadView() {
        homeView = HomeContactView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .systemGray4
        configHomeView()
        configCollectionView()
        configAlert()
        configIdentifierFirebase()
        configContato()
        addListenerRecuperarConversa()
    }
    
    private func configHomeView(){
        homeView?.navView.delegate(self)
    }
    
    private func configCollectionView(){
        homeView?.configCollectionViewProtocols(delegate: self, dataSource: self)
    }
    
    private func configAlert(){
        alert = Alert(controller: self)
    }
    
    private func configIdentifierFirebase(){
        auth = Auth.auth()
        db = Firestore.firestore()
        
        if let currentUser = auth?.currentUser{
            self.idUsuarioLogado = currentUser.uid
            self.emailUsuarioLogado = currentUser.email
        }
    }
    
    private func configContato(){
        contato = ContactController()
        contato?.delegate(self)
    }
    
    
    func addListenerRecuperarConversa(){
        if let idUsuarioLogado = auth?.currentUser?.uid{
            self.conversasListener = db?.collection("conversas").document(idUsuarioLogado).collection("ultimas_conversas").addSnapshotListener({ querSnapshot, error in
                if error == nil{
                    self.listaConversas.removeAll()
                    if let snapshot = querSnapshot{
                        for document in snapshot.documents{
                            let dados = document.data()
                            self.listaConversas.append(Conversation(dicionario: dados))
                        }
                        self.homeView?.reloadCollectionView()
                    }
                }
            })
        }
    }
    
    func getContato(){
        self.listContact.removeAll()
        self.db?.collection("usuarios").document(self.idUsuarioLogado ?? "").collection("contatos").getDocuments(completion: { snapShotResultado, error in
            if error != nil{
                print("error getContato")
                return
            }
            if let snapshot = snapShotResultado{
                for document in snapshot.documents{
                    let dadosContato = document.data()
//                    self.listContact.append(Contact(dicionario: dadosContato))
                    for (key, value) in dadosContato {
                        if key == "nome", let nome = value as? String {
                            self.listContact.append(nome)
                        }
                    }
                    print(self.listContact)

                }
                self.homeView?.reloadCollectionView()
            }
        })
    }
}

extension HomeContactViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.viewContact ?? false {
            return self.listContact.count + 1
        } else {
            return self.listaConversas.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.viewContact ?? false{
            if indexPath.row == self.listContact.count{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageLastCollectionViewCell.identifier, for: indexPath)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailCollectionViewCell.identifier, for: indexPath) as? MessageDetailCollectionViewCell
//                cell?.setupViewContact(contact: self.listContact[indexPath.row])
                cell?.userName.text = self.listContact[indexPath.row]
                return cell ?? UICollectionViewCell()
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailCollectionViewCell.identifier, for: indexPath) as? MessageDetailCollectionViewCell
//            cell?.setupViewConversation(conversation: self.listaConversas[indexPath.row])
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.viewContact ?? false{
            if indexPath.row == self.listContact.count{
                self.alert?.addContact(completion: { value in
                    self.contato?.addContact(email: value, emailUserLogado: self.emailUsuarioLogado ?? "", idUser: self.idUsuarioLogado ?? "")
                })
                
            } else {
                let vc: ChatViewController = ChatViewController()
//                vc.contato = self.listContact[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            
        }
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
            self.getContato()
            self.conversasListener?.remove()
        case .conversation:
            self.viewContact = false
            self.addListenerRecuperarConversa()
            self.homeView?.reloadCollectionView()
        }
    }
}

extension HomeContactViewController: ContactProtocol {
    func successContact() {
        self.alert?.getAlert(title: "eba", message: "usuário cadastrado com sucesso!!", completion: {
            self.getContato()
        })
    }
    
    func alertStateError(title titulo: String, message: String) {
        self.alert?.getAlert(title: titulo, message: message)
    }
}
