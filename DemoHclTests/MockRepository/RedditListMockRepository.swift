//
//  RedditListMockRepository.swift
//  DemoHclTests
//
//  Created by Vishal on 15/08/21.
//

@testable import DemoHcl

// Reddit List Mock Repository
class RedditListMockRepository: RedditListRepositoryProtocol {

    // MARK: -  Get Reddit List Data
    func getRedditListData(name: NetworkServiceName, result: @escaping ResultClosure) {
        NetworkMockService.fetch(name: name) { (_result: Result<RedditModel, Error>) in
            switch _result {
                case .success(let model):
                    result(.success(model))
                case .failure(let error):
                    result(.failure(error))
            }
        }
    }
}
