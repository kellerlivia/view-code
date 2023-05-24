//
//  HomeViewController.swift
//  view-code
//
//  Created by Livia Keller on 24/05/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var homeView: HomeView?
    var data: [UserData] = [UserData(name: "Lívia", nameImage: "person.fill"),
                            UserData(name: "Luisa", nameImage: "person.fill"),
                            UserData(name: "Eduarda", nameImage: "person.fill")]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func loadView() {
        self.homeView = HomeView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView?.configTableViewProtocols(delegate: self, dataSource: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: UserDetailTableViewCell.identifier, for: indexPath) as? UserDetailTableViewCell
        cell?.configCell(data: data[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
