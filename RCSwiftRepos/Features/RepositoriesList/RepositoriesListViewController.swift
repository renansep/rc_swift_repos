//
//  RepositoriesListViewController.swift
//  RCSwiftRepos
//
//  Created by Renan Cargnin on 27/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import UIKit

class RepositoriesListViewController: UIViewController {
    
    enum Event {
        case viewDidLoad(completion: (Result<Void, WebServiceError>) -> Void)
        case pullToRefresh(completion: (Result<Void, WebServiceError>) -> Void)
        case selection(row: Int)
        case reachedScrollEnd(completion: () -> Void)
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let refreshControl = UIRefreshControl()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .darkGray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let presenter: RepositoriesListPresenter
    private let viewModel: RepositoriesListViewModel
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------

    init(presenter: RepositoriesListPresenter) {
        self.presenter = presenter
        self.viewModel = presenter.viewModel
        
        super.init(
            nibName: nil,
            bundle: nil
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//-----------------------------------------------------------------------------
// MARK: - View lifecycle
//-----------------------------------------------------------------------------

extension RepositoriesListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Repositórios"
        
        view.backgroundColor = .white
        
        refreshControl.addTarget(self, action: #selector(pullToRefreshTriggered), for: .valueChanged)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(withClass: RepositoryCell.self)
        tableView.refreshControl = refreshControl
        
        configureConstraints()
        
        tableView.isHidden = true
        activityIndicator.startAnimating()
        presenter.handleEvent(.viewDidLoad(completion: { result in
            self.activityIndicator.stopAnimating()
            self.handleRequestResult(result)
        }))
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods
//-----------------------------------------------------------------------------

extension RepositoriesListViewController {
    
    private func configureConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func handleRequestResult(_ result: Result<Void, WebServiceError>) {
        switch result {
            
        case .success:
            self.tableView.reloadData()
            self.tableView.isHidden = false
            
        case .failure(let error):
            print(error)
        }
    }
}

//-----------------------------------------------------------------------------
// MARK: - Event handling
//-----------------------------------------------------------------------------

extension RepositoriesListViewController {
    
    @objc private func pullToRefreshTriggered() {
        presenter.handleEvent(.pullToRefresh(completion: { result in
            self.refreshControl.endRefreshing()
            self.handleRequestResult(result)
        }))
    }
}

//-----------------------------------------------------------------------------
// MARK: - UITableViewDatasource
//-----------------------------------------------------------------------------

extension RepositoriesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellsViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: RepositoryCell.self)
        cell.configure(with: viewModel.cellsViewModels[indexPath.row])
        return cell
    }
}

//-----------------------------------------------------------------------------
// MARK: - UITableViewDelegate
//-----------------------------------------------------------------------------

extension RepositoriesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.handleEvent(.selection(row: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == viewModel.cellsViewModels.count - 1 else { return }
        
        presenter.handleEvent(.reachedScrollEnd(completion: {
            tableView.reloadData()
        }))
    }
}
