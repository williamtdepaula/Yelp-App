//
//  Task+Sleep.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import Foundation

extension Task where Failure == Never, Success == Never {
    static func sleep(seconds: UInt64) async throws {
        try await Task.sleep(nanoseconds: seconds * 1_000_000_000)
    }
    
    static func sleep(milliseconds: UInt64) async throws {
        try await Task.sleep(nanoseconds: milliseconds * 1_000_000)
    }
}
