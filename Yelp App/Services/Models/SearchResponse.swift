//
//  SearchResponse.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

struct SearchResponse: Codable {
    let businesses: [Business]?
    let total: Int?
}
