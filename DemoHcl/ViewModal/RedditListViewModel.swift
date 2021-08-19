//
//  AppDelegate.swift
//  DemoHcl
//
//  Created by Vishal on 15/08/21.
//

import UIKit

// Input Protocols
protocol RedditListInputViewModel {
    func getRedditMethodList(name: NetworkServiceName)
}

// Output Protocols
protocol RedditListOutputViewModel {
    var  showError: Dynamic<Bool> { get }
    var  reloadTable: Dynamic<Bool> { get }
    
    func getDataForRows(indexPath: IndexPath) -> ChildData?
    func loadMoreDataList(indexPath: IndexPath) -> Bool
    func getNumberOfRows(section: Int) -> Int
    func getErrorMessage() -> String
    func getNavigationTitle() -> String
}

protocol RedditListViewModelType: RedditListInputViewModel, RedditListOutputViewModel {
    var input: RedditListInputViewModel { get }
    var output: RedditListOutputViewModel { get }
}

class RedditListViewModel: RedditListViewModelType {
    
    // Objects
    var input: RedditListInputViewModel { return self }
    var output: RedditListOutputViewModel { return self }
    var itemList: [Child?] = []
    var errorMsg: String?
    var reloadTable: Dynamic<Bool> = Dynamic(false)
    var showError: Dynamic<Bool> = Dynamic(false)
    
    private var afterValue:String?
    private var repository: RedditListRepositoryProtocol
    
    // initialize
    init(repository:RedditListRepositoryProtocol = RedditListRepository()){
        self.repository = repository
    }
    
    // Get Number Of Rows
    func getNumberOfRows(section: Int) -> Int {
        return self.itemList.count
    }
    
    // Get Error Message
    func getErrorMessage() -> String {
        return self.errorMsg ?? ""
    }
    
    // Get Navigation Title
    func getNavigationTitle() -> String {
        return Constants.NavigationBar.title
    }
    
    // Get Data for Cell Rows
    func getDataForRows(indexPath: IndexPath) -> ChildData? {
        let dataModel = self.itemList[indexPath.row]
        return dataModel?.data
    }
    
    // Get Reddit Method List
    func getRedditMethodList(name: NetworkServiceName) {
        repository.getRedditListData(name: name) { [weak self] (result) in
            switch result  {
            case .success(let model):
                if let model = model as? RedditModel, let data = model.data {
                    self?.afterValue = model.data?.after
                    self?.itemList.append(contentsOf:  data.children ?? [])
                    self?.reloadTable.value = true
                }
            case .failure(let error):
                let errorMessage = error is NetworkError ? (error as! NetworkError).errorDescription : error.localizedDescription
                self?.errorMsg = errorMessage
                self?.showError.value = true
            }
        }
    }
    
    // Load more data
    func loadMoreDataList(indexPath: IndexPath) -> Bool {
        if indexPath.row == self.itemList.count - 1 , let value = afterValue {
            getRedditMethodList(name: .redditList(after: value))
            return true
        }
        return false
    }
}


