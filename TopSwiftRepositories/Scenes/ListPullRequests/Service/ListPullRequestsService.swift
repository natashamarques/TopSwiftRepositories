//
//  ListPullRequestsService.swift
//  TopPythonRepositories
//
//  Created by Natasha Marques on 26/05/22.
//

import Foundation

protocol ListPullRequestsServiceProtocol {
    func fetchPullRequests(repository: Repository, completion: @escaping (Result<[PullRequest] ,NetworkError>) -> Void)
}

class ListPullRequestsService: ListPullRequestsServiceProtocol {

    let networkProvider = NetworkProvider.shared
    
    func fetchPullRequests(repository: Repository, completion: @escaping (Result<[PullRequest] ,NetworkError>) -> Void) {
        let requestProvider: ListPullRequestsProvider =  ListPullRequestsProvider(repository: repository)
        return networkProvider.request(url: requestProvider.url) { (result: Result<[PullRequest], NetworkError>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}


