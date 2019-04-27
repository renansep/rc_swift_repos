//
//  RepositoryWebServices.swift
//  RCSwiftRepos
//
//  Created by Renan Cargnin on 27/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import Foundation

class RepositoryWebServices {
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    let basePath = "/search/repositories"
    
    func mostStarred(
        languageName: String,
        page: Int,
        completion: @escaping (Result<[Repository], WebServiceError>) -> Void) {
        
        
        let path = basePath + "?q=language:\(languageName)&sort=stars&page=\(page)"
        
        Server(request: Server.Request(path: path)).call { result in
            switch result {
            case .success(let jsonData):
                
                struct Response: Decodable {
                    let items: [Repository]
                }
                
                guard let repositories = try? JSONDecoder().decode(Response.self, from: jsonData).items else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                completion(.success(repositories))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
