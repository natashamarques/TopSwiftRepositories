//
//  ListPullRequestsModel.swift
//  TopPythonRepositories
//
//  Created by Natasha Marques on 26/05/22.
//

struct  ListPullRequestModel: Codable {
    let pullRequests: [PullRequest]
}

struct PullRequest: Codable {
    let title: String
    let body: String?
    let user: Owner
}

struct Request {
    let author: String
    let repository: String
    
    init(repository: Repository) {
        self.author = repository.owner.login
        self.repository = repository.name
    }
    
}

