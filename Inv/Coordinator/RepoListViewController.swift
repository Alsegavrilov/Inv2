//
//  RepoListViewController.swift
//  Inv
//
//  Created by Александр Гаврилов on 24.02.2021.
//

import UIKit
import RealmSwift

class RepoListViewController: UIViewController {
    private let tableView = UITableView()
    let spinner = SpinnerViewController()
    var repos: [Repos]?
    let model = RepoList()
    var currentRepo: Int!
    
    
    init(repos: [Repos]) {
        super.init(nibName: nil, bundle: nil)
        
        self.repos = repos
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createSpinnerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        presentationController?.delegate = self
        setupView()
    }
    
    
    func setupView() {
        self.title = "Repositories"
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 5),
        ])
        view.updateConstraints()
    }
}

extension RepoListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return repos?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        removeSpinnerView() //TODO: -
        
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
        currentRepo = indexPath.section
        let popVC = PopOverViewController(link: repos![indexPath.section].url)
        popVC.modalPresentationStyle = .popover
        popVC.delegate = self
        let vc = popVC.popoverPresentationController!
        vc.permittedArrowDirections = []
        vc.delegate = self
        vc.sourceView = self.tableView
        popVC.preferredContentSize = CGSize(width: 250, height: 150)
        self.present(popVC, animated: true, completion: nil)
    }
    
    
    func createSpinnerView() {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
    
    func removeSpinnerView() {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
}


extension RepoListViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        print(#function)
        currentRepo = nil
    }
}

extension RepoListViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
extension RepoListViewController: PopOverDelegate { //TODO: - unique check
    func saveRepo() {
        print(#function)
        guard let item = currentRepo else { return }
        let tmp = repos![item]
 
        let saveRepo =  MyRepos()
        saveRepo.id = String(tmp.id)
        saveRepo.name = tmp.name ?? "none"
        saveRepo.language = tmp.language ?? "none"
        saveRepo.url = tmp.url ?? "https://github.com"
        saveRepo.specification = tmp.specification ?? "none"
        self.model.saveToList(saveRepo)
        
    }
}


