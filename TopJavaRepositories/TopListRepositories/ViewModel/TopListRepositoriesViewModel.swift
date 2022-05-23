//
//  TopListRepositoriesViewModel.swift
//  TopJavaRepositories
//
//  Created by Usertqi on 22/05/22.
//

import Foundation

class TopListRepositoriesViewModel {
    
    var coordinator: TopListRepositoriesCoordinatorProtocol?
    var viewController: TopListRepositoriesViewProtocol?
    var service: TopListRepositoriesServiceProtocol?
    
    var model: TopListRepositoriesModel?
    var error: NetworkError?
    
    func requestListRepositories() {
        DispatchQueue.main.async {
            self.service?.searchRepositories(page: 1, completion: { (result: Result<TopListRepositoriesModel, NetworkError>) in
                switch result {
                case .success(let response):
                    self.model = response
                    self.viewController?.reloadData()
                case .failure(let error):
                    self.error = error
                }
            })
        }
    }
    
    func numberOfRows() -> Int {
        return model?.repositories?.count ?? 0
    }
    
    func repositoryForIndex(index: Int) -> Repository? {
        return model?.repositories?[index]
    }
    
    func routePullRequests(index: Int) {
        coordinator?.routeToPullRequests()
    }
}
