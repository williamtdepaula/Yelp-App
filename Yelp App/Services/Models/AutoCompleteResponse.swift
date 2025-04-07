//
//  AutoCompleteResponse.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import Foundation

struct AutoCompleteResponse: Codable {
    let terms: [Term]?
}

struct Term: Codable {
    let text: String?
}
