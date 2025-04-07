//
//  SearchNetwork.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import Foundation

protocol SearchNetworkProtocol {
    func search(term: String, offset: Int) async throws -> SearchResponse
    func getAutoComplete(term: String) async throws -> AutoCompleteResponse
}

class SearchNetwork: SearchNetworkProtocol {
    let client = YelpAPIClient()
    
    func getAutoComplete(term: String) async throws -> AutoCompleteResponse {
        try await client.request(SearchAPI.autoComplete(term: term), responseType: AutoCompleteResponse.self)
    }
    
    func search(term: String, offset: Int) async throws -> SearchResponse {
        try await client.request(SearchAPI.search(term: term, offset: offset), responseType: SearchResponse.self)
    }
}
