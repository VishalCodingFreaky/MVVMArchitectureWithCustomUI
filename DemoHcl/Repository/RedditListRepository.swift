//
//  RedditListRepository.swift
//  DemoHcl
//
//  Created by Vishal on 15/08/21.
//

import Foundation

// Reddit List Repository Protocol
protocol RedditListRepositoryProtocol {
    func getRedditListData(name: NetworkServiceName, result: @escaping ResultClosure)
}

// Reddit List Repository
class RedditListRepository: RedditListRepositoryProtocol {
    
    // Get Reddit List Data
    func getRedditListData(name: NetworkServiceName, result: @escaping ResultClosure) {
        NetworkService.fetch(name: name) { (_result: Result<RedditModel, Error>) in
            switch _result {
            case .success(let model):
                result(.success(model))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
