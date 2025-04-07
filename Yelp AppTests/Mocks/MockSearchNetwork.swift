//
//  MockSearchBusiness.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import Foundation
@testable import Yelp_App

class MockSearchNetwork: SearchNetworkProtocol {
    func search(term: String, offset: Int) async throws -> Yelp_App.SearchResponse {
        .init(businesses: [.init(id: "1", imageUrl: nil, url: nil, name: "Pizza Mock", reviewCount: 10, rating: 3, isClosed: false, price: "$", location: nil)], total: 1)
    }
    
    func getAutoComplete(term: String) async throws -> Yelp_App.AutoCompleteResponse {
        .init(terms: [
            Term(text: "Mock0"),
            Term(text: "Mock1"),
            Term(text: "Mock2"),
            Term(text: "Mock3")
        ])
    }
    
}
