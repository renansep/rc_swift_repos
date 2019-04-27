//
//  RepositoryOwner.swift
//  RCSwiftRepos
//
//  Created by Renan Cargnin on 27/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import Foundation

extension Repository {
    
    struct Owner: Decodable {
        
        //-----------------------------------------------------------------------------
        // MARK: - Public properties
        //-----------------------------------------------------------------------------
        
        let avatarURL: URL
        let login: String
        
        //-----------------------------------------------------------------------------
        // MARK: - CodingKeys
        //-----------------------------------------------------------------------------
        
        private enum CodingKeys: String, CodingKey {
            case avatarURL = "avatar_url"
            case login
        }
    }
}
