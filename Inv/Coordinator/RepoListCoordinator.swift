//
//  RepoListCoordinator.swift
//  Inv
//
//  Created by Александр Гаврилов on 23.02.2021.
//

import UIKit

class RepoListCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var repoListViewController: RepoListViewController?

    private let repos: [Repos]
    
    
    init(presenter: UINavigationController, repos: [Repos]) {
        self.presenter = presenter
        self.repos = repos
    }
    
    func start() {
        let repoListViewController = RepoListViewController(repos: repos)
        repoListViewController.title = "Repo list"
        presenter.pushViewController(repoListViewController, animated: true)
        
        self.repoListViewController = repoListViewController
    
    }
}

