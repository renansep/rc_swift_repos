//
//  RepositoriesListCoordinator.swift
//  RCSwiftRepos
//
//  Created by Renan Cargnin on 27/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import UIKit

class RepositoriesListCoordinator {
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private weak var navigationController: UINavigationController?
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}

//-----------------------------------------------------------------------------
// MARK: - Public methods
//-----------------------------------------------------------------------------

extension RepositoriesListCoordinator {
    
    func handleEvent(_ event: RepositoriesListPresenter.Event) {
        switch event {
        
        case .selection(let repository):
            print(repository)
            // TODO: push repository detail, for example.
        }
    }
}
