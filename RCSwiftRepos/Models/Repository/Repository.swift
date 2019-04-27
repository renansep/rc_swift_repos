//
//  Repository.swift
//  RCSwiftRepos
//
//  Created by Renan Cargnin on 27/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    
    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    let name: String
    let starsCount: Int
    let owner: Owner
    
    //-----------------------------------------------------------------------------
    // MARK: - CodingKeys
    //-----------------------------------------------------------------------------
    
    private enum CodingKeys: String, CodingKey {
        case name
        case starsCount = "stargazers_count"
        case owner
    }
}
