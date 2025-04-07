//
//  SearchBusinessTests.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import XCTest
@testable import Yelp_App

final class SearchBusinessTests: XCTestCase {

    func testSearchWithSuccess() async throws {
        let mock = MockSearchNetwork()
        let business = SearchBusiness(searchNetwork: mock)

        let term = "Burger"
        
        let result = try await business.search(term: term, offset: 0)

        XCTAssertEqual(result.businesses?.count, 1)
    }
    
    func testGetSuggestionsWithSuccess() async throws {
        let mock = MockSearchNetwork()
        let business = SearchBusiness(searchNetwork: mock)

        let term = "Burger"
        
        let result = try await business.getAutoComplete(term: term)

        XCTAssertEqual(result.first, "Mock0")
    }
    
    func testSearchReturnsMultipleBusinesses() async throws {
        let mock = MockSearchNetworkMultipleResults()
        let business = SearchBusiness(searchNetwork: mock)

        let result = try await business.search(term: "Pizza", offset: 0)

        XCTAssertEqual(result.businesses?.count, 3)
        XCTAssertEqual(result.businesses?.first?.name, "Pizza Mock")
    }
}
