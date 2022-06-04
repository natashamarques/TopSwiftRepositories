//
//  NetworkingProvider.swift
//  TopSwiftRepositories
//
//  Created by Natasha Marques on 21/05/22.
//

import Foundation

struct NetworkProvider {
    
    private init() { }
    
    static let shared = NetworkProvider()
    
    func request<T: Decodable>(url: URL?, completion: @escaping (Result<T,NetworkError>) -> Void) {
        guard let url = url else {
            completion(.failure(NetworkError.mappingError))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            if let _ = error {
                completion(.failure(parseErrorFor(statusCode: statusCode)))
                return
            }
            if let parsedObj = data?.parse(asObject: T.self, usingKeyDecodingStrategy: .convertFromSnakeCase) {
                completion(.success(parsedObj))
            } else {
                completion(.failure(NetworkError.mappingError))
            }
        }.resume()
    }

    fileprivate func parseErrorFor(statusCode: Int) -> NetworkError {
        switch statusCode {
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        default:
            return .unknownError
        }
    }
}

extension Data {
    func parse<T: Decodable>(asObject model: T.Type, usingKeyDecodingStrategy strategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = strategy
            let resp = try decoder.decode(T.self, from: self)
            return resp
        } catch {
            print("Error: \(#function) - \(error)")
            return nil
        }
    }
}
