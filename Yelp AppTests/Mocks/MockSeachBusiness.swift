//
//  MockSeachBusiness.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import Foundation
@testable import Yelp_App

class MockSearchBusiness: SearchBusinessProtocol {
    let withError: Bool
    
    init(withError: Bool = false) {
        self.withError = withError
    }
    
    func search(term: String, offset: Int) async throws -> Yelp_App.SearchResponse {
        guard !withError else {
            throw YelpError.invalidResponse
        }
        
        return Yelp_App.SearchResponse(businesses: [.init(id: "1", imageUrl: nil, url: nil, name: "Pizza Mock", reviewCount: 10, rating: 3, isClosed: false, price: "$", location: nil)], total: 1)
    }
    
    func getAutoComplete(term: String) async throws -> [String] {
        guard !withError else {
            throw YelpError.invalidResponse
        }
        return ["Test"]
    }
    
}
