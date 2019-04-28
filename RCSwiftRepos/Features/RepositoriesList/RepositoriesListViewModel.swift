//
//  RepositoriesListViewModel.swift
//  RCSwiftRepos
//
//  Created by Renan Cargnin on 27/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import Foundation

class RepositoriesListViewModel {
    
    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    var cellsViewModels: [RepositoryCellViewModel]
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(cellsViewModels: [RepositoryCellViewModel]) {
        self.cellsViewModels = cellsViewModels
    }
}
