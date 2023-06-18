//
//  ChatViewController.swift
//  view-code
//
//  Created by Livia Keller on 17/06/23.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    var chatView: ChatView?
    
    override func loadView() {
        self.chatView = ChatView()
        view = chatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
