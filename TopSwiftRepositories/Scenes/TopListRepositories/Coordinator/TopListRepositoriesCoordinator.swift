//
//  TopListRepositoriesCoordinator.swift
//  TopSwiftRepositories
//
//  Created by Natasha Marques on 28/05/22.
//

import UIKit

protocol TopListRepositoriesCoordinatorProtocol {
    func routeToError(defaultError: DefaulErrorModel)
    func routeToPullRequests(repository: Repository)
}

class TopListRepositoriesCoordinator: TopListRepositoriesCoordinatorProtocol {

    var navigation: UINavigationController?
    
    init(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    func routeToError(defaultError: DefaulErrorModel) {
        DispatchQueue.main.async {
            let viewController = DefaultErrorViewController(model: defaultError)
            self.navigation?.pushViewController(viewController, animated: true)
        }
    }
    
    func routeToPullRequests(repository: Repository) {
        let viewController = ListPullRequestsViewController(repository: repository)
        let nav = UINavigationController(rootViewController: viewController)
        self.navigation?.present(nav, animated: true)
    }
 
}
