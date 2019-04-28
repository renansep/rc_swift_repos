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

//-----------------------------------------------------------------------------
// MARK: - Mocks
//-----------------------------------------------------------------------------

extension Repository {
    
    static var mock: Repository {
        let jsonString = """
        {
            "name": "repositoryName",
            "stargazers_count": 1,
            "owner": {
                "avatar_url": "https://www.apple.com",
                "login": "test"
            }
        }
        """
        return try! JSONDecoder().decode(Repository.self, from: jsonString.data(using: .utf8)!)
    }
}
