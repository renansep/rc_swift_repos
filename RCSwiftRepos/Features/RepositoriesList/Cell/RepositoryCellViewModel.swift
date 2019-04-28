//
//  RepositoryCellViewModel.swift
//  RCSwiftRepos
//
//  Created by Renan Cargnin on 27/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import Foundation

struct RepositoryCellViewModel {
    
    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    let name: String
    let starsCountText: String
    let ownerAvatarURL: URL
    let ownerName: String
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(name: String,
         starsCountText: String,
         ownerAvatarURL: URL,
         ownerName: String) {
        
        self.name = name
        self.starsCountText = starsCountText
        self.ownerAvatarURL = ownerAvatarURL
        self.ownerName = ownerName
    }
}
