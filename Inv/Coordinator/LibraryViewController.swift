//
//  LibraryViewController.swift
//  Inv
//
//  Created by Александр Гаврилов on 24.02.2021.
//

import UIKit
import RealmSwift

class LibraryViewController: UIViewController {
    private let tableView = UITableView()
    var repoList = RepoList()
    var repos: Results<MyRepos>?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        repos = repoList.queryListFromRealm()
        setupView()
    }
    
    func setupView() {
        self.title = "Library"
        self.tableView.separatorStyle = .none
        self.view.backgroundColor = UIColor(displayP3Red: 246/255.0, green: 248/255.0, blue: 251/255.0, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 36/255.0, green: 41/255.0, blue: 47/255.0, alpha: 1)
        self.tableView.backgroundColor = UIColor(displayP3Red: 246/255.0, green: 248/255.0, blue: 251/255.0, alpha: 1)
        
        [tableView].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 5),
        ])
        view.updateConstraints()
    }
    
}

extension LibraryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return repos?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RepoCell(style: .default, reuseIdentifier: "repoCell")
        cell.layer.cornerRadius = 20
        cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        cell.clipsToBounds = true
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(displayP3Red: 246/255.0, green: 248/255.0, blue: 251/255.0, alpha: 1)
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        cell.selectedBackgroundView = backgroundView
        cell.backgroundColor = UIColor.white 
        cell.name.text = repos![indexPath.section].name
        cell.language.text = repos![indexPath.section].language
        cell.specification.text = repos![indexPath.section].specification
    
        
        return cell
    }
    
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(displayP3Red: 246/255.0, green: 248/255.0, blue: 251/255.0, alpha: 1)
               return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let link = URL(string: repos![indexPath.section].url) else {return}
        
        let alert = UIAlertController(title: "wow...", message: "Would you like to visit GitHub?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { _ in
                UIApplication.shared.open(link)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("DELETE THIS REPO")
            let id = repos?[indexPath.item].id
            repoList.deleteRepoFromRealm(id!)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
}
