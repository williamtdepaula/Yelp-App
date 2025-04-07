//
//  OpenStatus.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import SwiftUI

struct OpenStatus: View {
    let isOpen: Bool
    
    var body: some View {
        Text(isOpen ? "OPEN NOW" : "CLOSED")
            .foregroundStyle(.white)
            .font(.system(size: 12, weight: .bold))
            .padding(4)
            .background(isOpen ? Color.green : Color.red)
            .cornerRadius(3)
    }
}

#Preview {
    OpenStatus(isOpen: true)
}
