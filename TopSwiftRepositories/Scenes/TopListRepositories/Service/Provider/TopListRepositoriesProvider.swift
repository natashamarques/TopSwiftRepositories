//
//  TopListRepositoriesProvider.swift
//  TopSwiftRepositories
//
//  Created by Natasha Marques on 28/05/22.
//

import Foundation

class TopRepositoriesProvider: RequestProviderProtocol {
    var path: String
    var queryItems: [URLQueryItem]
    
    init(page: Int) {
        path = "/search/repositories"
        queryItems = [
               URLQueryItem(name: "q", value: "language:swift"),
               URLQueryItem(name: "sort", value: "stars"),
               URLQueryItem(name: "per_page", value: "30"),
               URLQueryItem(name: "page", value: "\(page)")
           ]
    }
}

