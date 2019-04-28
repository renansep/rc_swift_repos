//
//  RepositoriesListCoordinator.swift
//  RCSwiftRepos
//
//  Created by Renan Cargnin on 27/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import UIKit

protocol RepositoriesListCoordinatorType {
    func handleEvent(_ event: RepositoriesListPresenter.Event)
}

class RepositoriesListCoordinator: Coordinator {
    
}

//-----------------------------------------------------------------------------
// MARK: - Public methods
//-----------------------------------------------------------------------------

extension RepositoriesListCoordinator: RepositoriesListCoordinatorType {
    
    func handleEvent(_ event: RepositoriesListPresenter.Event) {
        switch event {
        
        case .selection(let repository):
            print(repository)
            // TODO: push repository detail, for example.
        }
    }
}
