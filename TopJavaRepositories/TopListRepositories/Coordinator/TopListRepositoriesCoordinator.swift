//
//  TopListRepositoriesCoordinator.swift
//  TopJavaRepositories
//
//  Created by Usertqi on 22/05/22.
//

import UIKit

protocol TopListRepositoriesCoordinatorProtocol {
    func routeToPullRequests()
}

class TopListRepositoriesCoordinator: TopListRepositoriesCoordinatorProtocol {

    var navigation: UINavigationController?
    
    init(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    func routeToPullRequests() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        navigation?.pushViewController(viewController, animated: true)
    }
}
