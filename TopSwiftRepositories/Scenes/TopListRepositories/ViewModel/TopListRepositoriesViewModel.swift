//
//  TopListRepositoriesViewModel.swift
//  TopSwiftRepositories
//
//  Created by Natasha Marques on 28/05/22.
//

import Foundation
import UIKit

class TopListRepositoriesViewModel {
    
    var service: TopListRepositoriesService?
    var viewController: TopListRepositoriesViewProtocol?
    var coordinator: TopListRepositoriesCoordinatorProtocol?
    
    var model: TopListRepositoriesModel?
    var error: NetworkError?
    var currentPage = 1
        
    func fetchRepositories() {
        DispatchQueue.main.async {
            self.viewController?.showLoading()
            self.service?.searchRepositories(page: 1, completion: { (result: Result<TopListRepositoriesModel, NetworkError>) in
                self.viewController?.removeLoading()
                switch result {
                case .success(let response):
                    self.model = response
                    self.viewController?.reloadData()
                case .failure(let error):
                    self.error = error
                    self.showDefaultError()
                }
            })
        }
    }
    
    func fetchMoreRepositories(index: Int) {
        if model?.repositories?.count ?? 0 == (index + 10) {
            currentPage = currentPage + 1
            DispatchQueue.main.async {
                self.service?.searchRepositories(page: self.currentPage, completion: { (result: Result<TopListRepositoriesModel, NetworkError>) in
                    switch result {
                    case .success(let success):
                        self.model?.repositories?.append(contentsOf: success.repositories ?? [])
                        self.viewController?.reloadData()
                    case .failure(let error):
                        self.error = error
                        self.showDefaultError()
                    }
                })
            }
        }
    }
    
    func showDefaultError() {
        let defaultError = DefaulErrorModel(title: "Opps, Tivemos algum problema", subTitle: "Tente novamente mais tarde =/", iconImage: UIImage(named: "icon_error"))
        self.coordinator?.routeToError(defaultError: defaultError)
    }
    
    func numberOfRepositories() -> Int {
        return model?.repositories?.count ?? 0
    }
    
    func getRepositoryForIndex(index: Int) -> Repository? {
        return model?.repositories?[index]
    }
    
    func didSelectRow(index: Int) {
        guard let selectedRepository = getRepositoryForIndex(index: index) else { return }
        coordinator?.routeToPullRequests(repository: selectedRepository)
    }
}

