//
//  SearchBusiness.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

protocol SearchBusinessProtocol {
    func search(term: String, offset: Int) async throws -> SearchResponse
    func getAutoComplete(term: String) async throws -> [String]
}

class SearchBusiness: SearchBusinessProtocol {
    let searchNetwork: SearchNetworkProtocol
    
    init(searchNetwork: SearchNetworkProtocol) {
        self.searchNetwork = searchNetwork
    }
    
    func getAutoComplete(term: String) async throws -> [String] {
        let autoCompleteResponse = try await searchNetwork.getAutoComplete(term: term)
        
        return autoCompleteResponse.terms?.compactMap({ $0.text }) ?? []
    }
    
    func search(term: String, offset: Int) async throws -> SearchResponse {
        try await searchNetwork.search(term: term, offset: offset)
    }

}
