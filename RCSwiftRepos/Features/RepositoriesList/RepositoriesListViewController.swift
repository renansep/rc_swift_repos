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
        case selection(row: Int)
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(withClass: RepositoryCell.self)
        
        configureConstraints()
        requestRepositories()
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
    
    private func requestRepositories() {
        tableView.isHidden = true
        activityIndicator.startAnimating()
        
        presenter.requestRepositories { result in
            self.activityIndicator.stopAnimating()
            
            switch result {
                
            case .success:
                self.tableView.reloadData()
                self.tableView.isHidden = false
                
            case .failure(let error):
                print(error)
            }
        }
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
}
