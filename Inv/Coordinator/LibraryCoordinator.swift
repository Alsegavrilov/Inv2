//
//  LibraryCoordinator.swift
//  Inv
//
//  Created by Александр Гаврилов on 24.02.2021.
//

import UIKit

class LibraryCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var libraryViewController: LibraryViewController?    
    
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let libraryViewController = LibraryViewController()
        libraryViewController.title = "My Repos"
        presenter.pushViewController(libraryViewController, animated: true)
        self.libraryViewController = libraryViewController
    }
}
