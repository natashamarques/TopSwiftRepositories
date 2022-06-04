//
//  ListPullRequestsProvider.swift
//  TopPythonRepositories
//
//  Created by Natasha Marques on 26/05/22.
//

import Foundation

class ListPullRequestsProvider: RequestProviderProtocol {
    var path: String
    var queryItems: [URLQueryItem]
    
    init(repository: Repository) {
        path = "/repos/\(repository.owner.login)/\(repository.name)/pulls"
        queryItems = []
    }
}



