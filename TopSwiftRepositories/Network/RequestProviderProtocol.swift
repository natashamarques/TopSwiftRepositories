//
//  RequestProviderProtocol.swift
//  TopSwiftRepositories
//
//  Created by Natasha Marques on 21/05/22.
//

import Foundation

protocol RequestProviderProtocol {
    var path: String { get set }
    var queryItems: [URLQueryItem] { get set }
}

extension RequestProviderProtocol {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
