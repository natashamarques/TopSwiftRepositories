//
//  ListPullRequestsViewModel.swift
//  TopPythonRepositories
//
//  Created by Natasha Marques on 26/05/22.
//

import Foundation

class ListPullRequestsViewModel {
    
    var service: ListPullRequestsServiceProtocol?
    var viewController: ListPullRequestsViewProtocol?
    
    var model: [PullRequest] = []
    var error: NetworkError?
    var selectedRepository: Repository
    
    init(repository: Repository) {
        selectedRepository = repository
    }
    
    func fetchPullRequests() {
        DispatchQueue.main.async {
            self.service?.fetchPullRequests(repository: self.selectedRepository, completion: { ( result: Result<[PullRequest], NetworkError>) in
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
    
    func numberOfPullRequests() -> Int {
        return model.count
    }
    
    func getPullRequestForIndex(index: Int) -> PullRequest {
        return model[index]
    }
    
}
