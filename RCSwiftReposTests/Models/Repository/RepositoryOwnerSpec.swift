//
//  RepositoryOwnerSpec.swift
//  RCSwiftReposTests
//
//  Created by Renan Cargnin on 28/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import Quick
import Nimble

@testable import RCSwiftRepos

class RepositoryOwnerSpec: QuickSpec {
    
    override func spec() {
        
        describe("decoding") {
            context("with valid JSON") {
                let jsonString = """
                {
                    "avatar_url": "https://www.apple.com",
                    "login": "test"
                }
                """
                let jsonData = jsonString.data(using: .utf8)!
                let owner = try? JSONDecoder().decode(Repository.Owner.self, from: jsonData)
                
                it("returns an owner") {
                    expect(owner).toNot(beNil())
                }
            }
            
            context("with invalid JSON [1]") {
                let jsonString = """
                {
                    "avatar_url1": "https://www.apple.com",
                    "login": "test"
                }
                """
                let jsonData = jsonString.data(using: .utf8)!
                let owner = try? JSONDecoder().decode(Repository.Owner.self, from: jsonData)
                
                it("returns nil") {
                    expect(owner).to(beNil())
                }
            }
            
            context("with invalid JSON [2]") {
                let jsonString = """
                {
                    "avatar_url": 1,
                    "login": "test"
                }
                """
                let jsonData = jsonString.data(using: .utf8)!
                let owner = try? JSONDecoder().decode(Repository.Owner.self, from: jsonData)
                
                it("returns nil") {
                    expect(owner).to(beNil())
                }
            }
        }
    }
}
