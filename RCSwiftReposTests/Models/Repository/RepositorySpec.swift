//
//  RepositorySpec.swift
//  RCSwiftReposTests
//
//  Created by Renan Cargnin on 28/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import RCSwiftRepos

class RepositorySpec: QuickSpec {
    
    override func spec() {
        
        describe("decoding") {
            context("with valid JSON") {
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
                let jsonData = jsonString.data(using: .utf8)!
                let owner = try? JSONDecoder().decode(Repository.self, from: jsonData)
                
                it("returns a repository") {
                    expect(owner).toNot(beNil())
                }
            }
            
            context("with invalid JSON [1]") {
                let jsonString = """
                {
                    "name1": "repositoryName",
                    "stargazers_count": 1,
                    "owner": {
                        "avatar_url": "https://www.apple.com",
                        "login": "test"
                    }
                }
                """
                let jsonData = jsonString.data(using: .utf8)!
                let owner = try? JSONDecoder().decode(Repository.self, from: jsonData)
                
                it("returns a repository") {
                    expect(owner).to(beNil())
                }
            }
            
            context("with invalid JSON [2]") {
                let jsonString = """
                {
                    "name": 1,
                    "stargazers_count": 1,
                    "owner": {
                        "avatar_url": "https://www.apple.com",
                        "login": "test"
                    }
                }
                """
                let jsonData = jsonString.data(using: .utf8)!
                let owner = try? JSONDecoder().decode(Repository.self, from: jsonData)
                
                it("returns a repository") {
                    expect(owner).to(beNil())
                }
            }
        }
    }
}

extension Repository: Equatable {
    
    public static func == (lhs: Repository, rhs: Repository) -> Bool {
        return lhs.name == rhs.name && lhs.starsCount == rhs.starsCount && lhs.owner == rhs.owner
    }
}
