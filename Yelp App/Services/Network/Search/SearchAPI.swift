//
//  SearchAPI.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import Foundation

enum SearchAPI: YelpEndpoint {
    
    case autoComplete(term: String)
    case search(term: String, offset: Int)
    
    var url: URL {
        switch self {
        case .autoComplete:
            return URL(string: "https://api.yelp.com/v3/autocomplete")!
        case .search:
            return URL(string: "https://api.yelp.com/v3/businesses/search")!
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .autoComplete(let term):
            return [
                URLQueryItem(name: "text", value: term),
                URLQueryItem(name: "latitude", value: "33.669445"),
                URLQueryItem(name: "longitude", value: "-117.823059")
            ]
        case .search(let term, let offset):
            return [
                URLQueryItem(name: "latitude", value: "33.669445"),
                URLQueryItem(name: "longitude", value: "-117.823059"),
                URLQueryItem(name: "term", value: term),
                URLQueryItem(name: "sort_by", value: "best_match"),
                URLQueryItem(name: "limit", value: "20"),
                URLQueryItem(name: "offset", value: String(offset))
            ]
        }
    }
}
