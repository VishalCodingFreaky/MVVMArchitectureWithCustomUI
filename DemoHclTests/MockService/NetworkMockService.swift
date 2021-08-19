//
//  NetworkMockService.swift
//  DemoHclTests
//
//  Created by Vishal on 15/08/21.
//

import Foundation
@testable import DemoHcl

// MARK: - Mock Service
struct NetworkMockService:NetworkServiceProtocol {
    
    static func fetch<DataType: Decodable>( name:NetworkServiceName?, completion: @escaping (Result<DataType, Error>) -> ()) {
        switch name {
        case .reddit:
            completion(.success(.parse(jsonFile: "redditList")))
        default:
            completion(.failure(NetworkError.unableToParseData))
        }
    }
}

// MARK: - Parse Local Json
extension Decodable {
    static func parse(jsonFile: String) -> Self {
        guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let output = try? JSONDecoder().decode(self, from: data)
        else {
            return self as! Self
        }
        return output
    }
}
