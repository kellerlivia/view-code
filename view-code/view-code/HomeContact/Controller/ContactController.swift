//
//  ContactController.swift
//  view-code
//
//  Created by Livia Keller on 30/05/23.
//

import UIKit
import Firebase

protocol ContactProtocol: AnyObject {
    func alertStateError(title: String, message: String)
    func successContact()
}

class ContactController: UIViewController {
    
    weak var delegate: ContactProtocol?
    
    public func delegate(_ delegate: ContactProtocol?) {
        self.delegate = delegate
    }
    
    func addContact(email: String, emailUserLogado: String, idUser: String) {
        if email == emailUserLogado {
            self.delegate?.alertStateError(title: "esse é seu proprio email", message: "adicione um email diferente")
            return
        }
        
        let firestore = Firestore.firestore()
        firestore.collection("usuarios").whereField("email", isEqualTo: email).getDocuments { snapshotResult, error in
            if let totalItens = snapshotResult?.count {
                if totalItens == 0 {
                    self.delegate?.alertStateError(title: "usuario nao cadastrado", message: "verifique o email e tente novamente!")
                    return
                }
            }
            
            if let snapshot = snapshotResult {
                for document in snapshot.documents {
                    let dados = document.data()
                    self.saveContact(dadosContact: dados, idUser: idUser)
                }
            }
        }
    }
    
    func saveContact(dadosContact: Dictionary<String, Any>, idUser: String) {
        let contact: Contact = Contact(dicionario: dadosContact)
        let firestore = Firestore.firestore()
        firestore.collection("usuarios").document(idUser).collection("contatos").document(contact.id ?? "").setData(dadosContact) {(error) in
            if error == nil {
                self.delegate?.successContact()
            }
        }
    }
}
