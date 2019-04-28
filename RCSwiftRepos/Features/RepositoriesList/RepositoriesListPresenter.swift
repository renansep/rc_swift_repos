//
//  RepositoriesListPresenter.swift
//  RCSwiftRepos
//
//  Created by Renan Cargnin on 27/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import Foundation

class RepositoriesListPresenter {
    
    enum Event {
        case selection(Repository)
    }

    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    let viewModel: RepositoriesListViewModel
    
    var repositories: [Repository] = []
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let coordinator: RepositoriesListCoordinatorType
    
    private var currentPage: Int = 1
    private var isLoadingNextPage = false
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(coordinator: RepositoriesListCoordinatorType) {
        self.coordinator = coordinator
        self.viewModel = RepositoriesListViewModel(cellsViewModels: [])
    }
}

//-----------------------------------------------------------------------------
// MARK: - Public methods
//-----------------------------------------------------------------------------

extension RepositoriesListPresenter {
    
    func handleEvent(_ event: RepositoriesListViewController.Event) {
        switch event {
            
        case .viewDidLoad(let completion):
            requestRepositories(completion: completion)
            
        case .pullToRefresh(let completion):
            currentPage = 1
            requestRepositories(completion: completion)

        case .selection(let row):
            guard repositories.indices.contains(row) else { return }
            
            coordinator.handleEvent(.selection(repositories[row]))
            
        case .reachedScrollEnd(let completion):
            requestNextPageIfNeeded(completion: completion)
        }
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods
//-----------------------------------------------------------------------------

extension RepositoriesListPresenter {
    
    private func requestRepositories(completion: @escaping (Result<Void, WebServiceError>) -> Void) {
        RepositoryWebServices().mostStarred(
            languageName: "swift",
            page: currentPage,
            completion: { result in
                switch result {
                    
                case .success(let repositories):
                    if self.currentPage == 1 {
                        self.repositories = []
                        self.viewModel.cellsViewModels = []
                    }
                    
                    self.repositories += repositories
                    
                    self.viewModel.cellsViewModels += repositories.map {
                        return RepositoryCellViewModel(
                            name: $0.name,
                            starsCountText: "\($0.starsCount)",
                            ownerAvatarURL: $0.owner.avatarURL,
                            ownerName: $0.owner.login
                        )
                    }
                    
                    self.currentPage += 1
                    
                    completion(.success(()))
                    
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
        )
    }
    
    private func requestNextPageIfNeeded(completion: @escaping () -> Void) {
        guard !isLoadingNextPage else { return }
        
        isLoadingNextPage = true
        requestRepositories { result in
            self.isLoadingNextPage = false
            completion()
        }
    }
}
