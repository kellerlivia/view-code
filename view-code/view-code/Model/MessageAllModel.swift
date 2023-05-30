//
//  MessageAllModel.swift
//  view-code
//
//  Created by Livia Keller on 29/05/23.
//

import Foundation

class Message {
    var text: String?
    var idUser: String?
    
    init(dicionario: [String: Any]) {
        text = dicionario["text"] as? String
        idUser = dicionario["idUser"] as? String
    }
}

class Conversation {
    var name: String?
    var lastMessage: String?
    var idDestinatario: String?
    
    init(dicionario: [String: Any]) {
        name = dicionario["name"] as? String
        lastMessage = dicionario["lastMessage"] as? String
        idDestinatario = dicionario["idDestinatario"] as? String
    }
}

class User {
    var name: String?
    var email: String?
    
    init(dicionario: [String: Any]) {
        name = dicionario["name"] as? String
        email = dicionario["email"] as? String
    }
}

class Contact {
    var id: String?
    var name: String?
    
    init(dicionario: [String: Any]?) {
        id = dicionario?["id"] as? String
        name = dicionario?["name"] as? String
    }
    
    convenience init(id: String?, name: String?) {
        self.init(dicionario: nil)
        self.id = id
        self.name = name
    }
}
