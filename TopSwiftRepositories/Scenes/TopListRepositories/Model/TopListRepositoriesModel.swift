//
//  TopListRepositoriesModel.swift
//  TopSwiftRepositories
//
//  Created by Natasha Marques on 28/05/22.
//

import Foundation

struct TopListRepositoriesModel: Codable {
    
    var repositories: [Repository]?
    
    enum CodingKeys: String, CodingKey {
        case repositories = "items"
    }
}

struct Repository: Codable {
    var name: String
    var stargazersCount: Int
    var description: String?
    var forksCount: Int
    var owner: Owner
}

struct Owner: Codable {
    var login: String
    var avatarUrl: String
}
