//
//  YelpEndPoint.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import Foundation

protocol YelpEndpoint {
    var url: URL { get }
    var queryItems: [URLQueryItem] { get }
}
