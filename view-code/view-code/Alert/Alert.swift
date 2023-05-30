//
//  Alert.swift
//  view-code
//
//  Created by Livia Keller on 29/05/23.
//

import Foundation
import UIKit

class Alert:NSObject{
    
    var controller:UIViewController
    
    init(controller:UIViewController) {
        self.controller = controller
    }
    
    func getAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelar = UIAlertAction(title: "OK", style: .cancel) { acao in
            completion?()
        }
        alertController.addAction(cancelar)
        self.controller.present(alertController, animated: true, completion: nil)
    }
    
    func addContact(completion: ((_ value:String) -> Void)? = nil) {
        var _textField:UITextField?
        let alert = UIAlertController(title: "adicionar usuário", message: "digite uma email válido", preferredStyle: .alert)
        let ok = UIAlertAction(title: "adicionar", style: .default) { (acao) in
            completion?(_textField?.text ?? "")
        }
        let cancel = UIAlertAction(title: "cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            _textField = textField
            textField.placeholder = "email:"
        })
        self.controller.present(alert, animated: true, completion: nil)
    }
}
