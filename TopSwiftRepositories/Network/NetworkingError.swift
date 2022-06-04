//
//  NetworkingError.swift
//  TopSwiftRepositories
//
//  Created by Natasha Marques on 21/05/22.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case unauthorized
    case forbidden
    case notFound
    case mappingError
    case emptyResponseDataError
    case unknownError
}
