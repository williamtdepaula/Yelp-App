//
//  MainViewModelTests.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import XCTest
@testable import Yelp_App

final class MainViewModelTests: XCTestCase {
    
    func testSearchWithSuccess() async throws {
        let viewModel = MainScreenViewModel(searchBusiness: MockSearchBusiness())
        let expectation = XCTestExpectation(description: "Businesses loaded")

        let term = "Burger"

        let cancellable = viewModel.$businesses
            .dropFirst()
            .sink { businesses in
                if !businesses.isEmpty {
                    expectation.fulfill()
                }
            }

        viewModel.resetSearch(newTerm: term)

        await fulfillment(of: [expectation], timeout: 5)

        XCTAssertEqual(viewModel.businesses.count, 1)
        XCTAssertEqual(viewModel.businesses.first?.name, "Pizza Mock")
        XCTAssertEqual(viewModel.screenState, .loadedSuccessfully)

        cancellable.cancel()
    }
    
    
    func testScreenStateTransitionsDuringSearch() async throws {
        let viewModel = MainScreenViewModel(searchBusiness: MockSearchBusiness())

        var receivedStates: [ScreenState] = []
        let expectation = XCTestExpectation(description: "Received all expected screenStates")
        expectation.expectedFulfillmentCount = 2

        let cancellable = viewModel.$screenState
            .dropFirst()
            .sink { state in
                receivedStates.append(state)
                expectation.fulfill()
            }

        viewModel.resetSearch(newTerm: "Pizza")

        await fulfillment(of: [expectation], timeout: 5)

        XCTAssertEqual(receivedStates, [.loading, .loadedSuccessfully])

        cancellable.cancel()
    }
    
    func testGetAutoCompleteWithSuccess() async throws {
        let viewModel = MainScreenViewModel(searchBusiness: MockSearchBusiness())
        let expectation = XCTestExpectation(description: "autoComplete loaded")

        let term = "Burger"

        let cancellable = viewModel.$autoCompleteOptions
            .dropFirst()
            .sink { businesses in
                if !businesses.isEmpty {
                    expectation.fulfill()
                }
            }

        viewModel.onSearchChanged(newSearch: term)

        await fulfillment(of: [expectation], timeout: 5)

        XCTAssertEqual(viewModel.autoCompleteOptions.count, 1)
        XCTAssertEqual(viewModel.autoCompleteOptions.first, "Test")

        cancellable.cancel()
    }
    
    func testSearchWithFailure() async throws {
        let viewModel = MainScreenViewModel(searchBusiness: MockSearchBusiness(withError: true))
        let expectation = XCTestExpectation(description: "$screenState changed")

        let term = "Burger"

        let cancellable = viewModel.$screenState
            .dropFirst()
            .sink { businesses in
                expectation.fulfill()
            }

        viewModel.resetSearch(newTerm: term)

        await fulfillment(of: [expectation], timeout: 5)

        XCTAssertEqual(viewModel.businesses.count, 0)
        XCTAssertEqual(viewModel.screenState, .error)

        cancellable.cancel()
    }
}
