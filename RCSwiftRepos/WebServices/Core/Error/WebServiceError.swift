//
//  WebServiceError.swift
//  RCSwiftRepos
//
//  Created by Renan Cargnin on 27/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import Foundation

enum WebServiceError: Error {
    case cantCreateURL
    case generic
    case invalidResponse
}
