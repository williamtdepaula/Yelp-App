//
//  View+Extensions.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import SwiftUI

extension View {
    func frame(_ frame: CGSize? = nil, aligment: Alignment = .center) -> some View {
        if let frame {
            return self.frame(width: frame.width, height: frame.height, alignment: aligment)
        }
        
        return self.frame(alignment: aligment)
    }
}
