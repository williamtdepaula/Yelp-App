//
//  Loading.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import SwiftUI

struct Loading: View {
    let scaleX: CGFloat
    let scaleY: CGFloat
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .scaleEffect(x: scaleX, y: scaleY, anchor: .center)
    }
}

#Preview {
    Loading(scaleX: 1, scaleY: 1)
}
