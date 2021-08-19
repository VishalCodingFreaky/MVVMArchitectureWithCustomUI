//
//  AppDelegate.swift
//  DemoHcl
//
//  Created by Vishal on 15/08/21.
//

import UIKit

class RedditListViewController: UIViewController {
    
    //Objects
    var viewModal: RedditListViewModelType = RedditListViewModel()
    let tblView = UITableView()
    
    // ViewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        fetchRedditList()
    }
    
    // MARK: - SetUp UI
    private func setUpUI(){
        setUpParentView()
        setUpTableView()
        closureSetup()
    }
    
    // MARK: - Fetch Reddit List
    private func fetchRedditList() {
        self.showLoading()
        viewModal.input.getRedditMethodList(name: .reddit)
    }
    
    // MARK: - SetUp ParentView
    private func setUpParentView() {
        navigationItem.title = viewModal.output.getNavigationTitle()
        navigationController?.navigationBar.barTintColor = UIColor.systemBlue
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        view.backgroundColor = .white
        view.addSubview(tblView)
    }
    
    // MARK: - SetUp TableView
    private func setUpTableView() {
        tblView.register(RedditListCell.self, forCellReuseIdentifier: Constants.Identifiers.redditListCell)
        tblView.fillInSuperview()
        tblView.dataSource = self
        tblView.delegate = self
        
        self.tblView.showsVerticalScrollIndicator = false
        self.tblView.separatorColor = .clear
    }
    
    // MARK: -Closure SetUp
    private func closureSetup() {
        // Reload Data
        viewModal.output.reloadTable.bind {[weak self] (_) in
            self?.hideLoading()
            DispatchQueue.main.async {
                self?.tblView.reloadData()
            }
        }
        
        // Show Error
        viewModal.output.showError.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.dismiss(animated: true, completion: { [weak self] in
                    self?.showAlert(withMessage: (self?.viewModal.output.getErrorMessage())!)
                })}
        }
    }
    
}

// MARK: - TableView Delegate and Data Source
extension RedditListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModal.output.getNumberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.redditListCell, for: indexPath) as? RedditListCell {
            cell.item =  viewModal.output.getDataForRows(indexPath: indexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModal.output.loadMoreDataList(indexPath: indexPath) {
            self.showLoading()
        }
    }
}
