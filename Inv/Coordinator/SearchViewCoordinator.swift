//
//  SearchViewCoordinator.swift
//  Inv
//
//  Created by Александр Гаврилов on 23.02.2021.
//
import UIKit

class SearchViewCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var searchViewController: SearchViewController?
    private var repoListCoordinator: RepoListCoordinator?
    private var libraryCoordinator: LibraryCoordinator?
    
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let searchViewController = SearchViewController()
        searchViewController.title = "GitHub repo search"
        
        
        presenter.pushViewController(searchViewController, animated: true)
        
        self.searchViewController = searchViewController
        searchViewController.delegate = self
        
    }
}

extension SearchViewCoordinator: RepoSearchDelegate {
    func openLibrary() {
        print(#function)
        let libraryCoordinator = LibraryCoordinator(presenter: self.presenter)
        libraryCoordinator.start()
        self.libraryCoordinator = libraryCoordinator
    }
    
    func requestRepo(_ repoName: String) {
        Network().getRepoSearch(title: repoName) { items in
            let repoListCoordinator = RepoListCoordinator(presenter: self.presenter, repos: items!)
            DispatchQueue.main.async {
                repoListCoordinator.start()
                
                self.repoListCoordinator = repoListCoordinator
            }
        }
    }
    
}
