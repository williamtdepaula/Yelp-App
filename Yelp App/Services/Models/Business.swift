//
//  Business.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//
import Foundation

struct Business: Codable, Identifiable {
    let id: String?
    let imageUrl: String?
    let url: String?
    let name: String?
    let reviewCount: Int?
    let rating: Double?
    let isClosed: Bool?
    let price: String?
    let location: Location?

    var descriptionFormatted: String {
        let address = location?.firstAddress
        let price = self.price
        
        return [address, price]
            .compactMap { $0 }
            .joined(separator: " • ")
    }
}

struct Location: Codable {
    let displayAddress: [String]?
    
    var firstAddress: String? {
        displayAddress?.first
    }
}
