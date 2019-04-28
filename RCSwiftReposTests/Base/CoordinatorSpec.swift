//
//  RepositoriesListCoordinatorSpec.swift
//  RCSwiftReposTests
//
//  Created by Renan Cargnin on 28/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import RCSwiftRepos

class CoordinatorSpec: QuickSpec {
    
    override func spec() {
        describe("init") {
            context("when I initialize the coordinator") {
                let navigationController = UINavigationController()
                let coordinator = Coordinator(navigationController: navigationController)
                
                it("assigns the navigationController property correctly") {
                    expect(coordinator.navigationController) === navigationController
                }
            }
        }
    }
}
