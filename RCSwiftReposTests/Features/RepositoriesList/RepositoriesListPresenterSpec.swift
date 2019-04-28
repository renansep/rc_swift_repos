//
//  RepositoriesListPresenterSpec.swift
//  RCSwiftReposTests
//
//  Created by Renan Cargnin on 28/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import RCSwiftRepos

class RepositoriesListCoordinatorSpy: RepositoriesListCoordinatorType {
    
    var selectionCallsParams: [Repository] = []
    
    func handleEvent(_ event: RepositoriesListPresenter.Event) {
        switch event {
            
        case .selection(let repository):
            selectionCallsParams.append(repository)
        }
    }
}

class RepositoriesListPresenterSpec: QuickSpec {
    
    override func spec() {
        describe("handleEvent: selection") {
            context("when I call handleEvent method with selection event") {
                let repositoryMock = Repository.mock
                
                let coordinator = RepositoriesListCoordinatorSpy()
                let presenter = RepositoriesListPresenter(coordinator: coordinator)
                presenter.repositories = [repositoryMock]
                presenter.handleEvent(.selection(row: 0))
                
                it("calls the correct handler in coordinator with the correct params") {
                    expect(coordinator.selectionCallsParams.count) == 1
                    expect(coordinator.selectionCallsParams[0]) == repositoryMock
                }
            }
        }
    }
}
