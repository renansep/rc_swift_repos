//
//  ServerRequest.swift
//  RCSwiftRepos
//
//  Created by Renan Cargnin on 27/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import Foundation

extension Server {
    
    class Request {
        
        //-----------------------------------------------------------------------------
        // MARK: - Public properties
        //-----------------------------------------------------------------------------
        
        let path: String
        
        //-----------------------------------------------------------------------------
        // MARK: - Initialization
        //-----------------------------------------------------------------------------
        
        init(path: String) {
            self.path = path
        }
    }
    
}
