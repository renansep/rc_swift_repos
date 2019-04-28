//
//  Coordinator.swift
//  RCSwiftRepos
//
//  Created by Renan Cargnin on 28/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import Foundation

class Coordinator {
    
    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    weak var navigationController: UINavigationController?
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}
