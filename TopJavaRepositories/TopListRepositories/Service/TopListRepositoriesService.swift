//
//  TopListRepositoriesService.swift
//  TopJavaRepositories
//
//  Created by Usertqi on 22/05/22.
//

import Foundation

protocol TopListRepositoriesServiceProtocol {
    func searchRepositories(page: Int, completion: @escaping (Result<TopListRepositoriesModel ,NetworkError>) -> Void)
}

class TopListRepositoriesService: TopListRepositoriesServiceProtocol {

    let networkProvider = NetworkProvider.shared
    
    func searchRepositories(page: Int, completion: @escaping (Result<TopListRepositoriesModel ,NetworkError>) -> Void) {
        let requestProvider: TopRepositoriesProvider =  TopRepositoriesProvider(page: page)
        return networkProvider.request(url: requestProvider.url) { (result: Result<TopListRepositoriesModel, NetworkError>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
