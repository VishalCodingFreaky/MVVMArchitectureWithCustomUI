//
//  RedditListViewModelTest.swift
//  DemoHclTests
//
//  Created by Vishal on 15/08/21.
//

import XCTest
@testable import DemoHcl

class RedditListViewModelTest: XCTestCase {

    // Objects
    var viewModel: RedditListViewModel!
    var mockRepository:RedditListMockRepository!
    
    // MARK: - setUp
    override func setUp() {
        mockRepository = RedditListMockRepository()
        viewModel = .init(repository: mockRepository)
    }
   
    // MARK: - Reddit method Success
    func testRedditMehtodListSuccess() {
        viewModel.getRedditMethodList(name: .reddit)
        XCTAssertNotNil(viewModel.itemList)
        XCTAssertGreaterThan(viewModel.getNumberOfRows(section: 0), 0)
        XCTAssertNotNil(viewModel.getDataForRows(indexPath: IndexPath(row: 0, section: 0)))
        XCTAssertTrue(viewModel.reloadTable.value)
    }
    
    // MARK: -  Reddit method Failure
    func testRedditMehtodListFailure() {
        viewModel.getRedditMethodList(name: .method)
        XCTAssertNotNil(viewModel.getErrorMessage())
        XCTAssertEqual(viewModel.getErrorMessage(), NetworkError.unableToParseData.errorDescription)
    }
    
    // MARK: - Test Title
    func testTitle() {
        XCTAssertEqual(viewModel.getNavigationTitle(), Constants.NavigationBar.title)
    }
}


