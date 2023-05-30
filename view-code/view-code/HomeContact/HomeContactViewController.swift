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
    
    override func loadView() {
        self.homeContactView = HomeContactView()
        view = homeContactView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemGray4
    }
}
