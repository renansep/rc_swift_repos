//
//  Server.swift
//  RCSwiftRepos
//
//  Created by Renan Cargnin on 27/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import Foundation

class Server {
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    let request: Request
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(request: Request) {
        self.request = request
    }
}

//-----------------------------------------------------------------------------
// MARK: - Public methods
//-----------------------------------------------------------------------------

extension Server {
    
    func call(completion: @escaping (Result<Data, WebServiceError>) -> Void) {
        let fullPath = "https://api.github.com" + request.path
        
        guard let url = URL(string: fullPath) else {
            completion(.failure(.cantCreateURL))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(.generic))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.generic))
                    return
                }
                
                guard 200...299 ~= httpResponse.statusCode else {
                    completion(.failure(.generic))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.generic))
                    return
                }
                
                completion(.success(data))
            }
        }).resume()
    }
}
