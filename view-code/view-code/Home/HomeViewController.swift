//
//  HomeViewController.swift
//  view-code
//
//  Created by Livia Keller on 24/05/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var homeView: HomeView?
    var dataUser: [UserData] = [UserData(name: "Lívia", nameImage: "person.fill"),
                            UserData(name: "Luisa", nameImage: "person.fill"),
                            UserData(name: "Eduarda", nameImage: "person.fill")]
    
    var dataSport: [Sport] = [Sport(name: "corrida", nameImage: "person.fill"),
                              Sport(name: "natação", nameImage: "person.fill"),
                              Sport(name: "ballet", nameImage: "person.fill"),
                              Sport(name: "ginástica", nameImage: "person.fill")]
    
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
        return dataUser.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 3 {
            let cell: SportTableViewCell? = tableView.dequeueReusableCell(withIdentifier: SportTableViewCell.identifier, for: indexPath) as? SportTableViewCell
            cell?.dataCollection(data: dataSport)
            return cell ?? UITableViewCell()
        }
        
        let cell: UserDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: UserDetailTableViewCell.identifier, for: indexPath) as? UserDetailTableViewCell
        cell?.configCell(data: dataUser[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
