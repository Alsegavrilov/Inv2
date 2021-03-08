//
//  ApplicationCoordinator.swift
//  Inv
//
//  Created by Александр Гаврилов on 23.02.2021.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: UINavigationController
    let searchCoordinator: SearchViewCoordinator

    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        searchCoordinator = SearchViewCoordinator(presenter: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        searchCoordinator.start()
        window.makeKeyAndVisible()
    }
}
