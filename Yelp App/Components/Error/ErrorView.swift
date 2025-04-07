//
//  SearchBar.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack {
            Image("error")
                .resizable()
                .frame(width: 400, height: 400)
                .scaledToFit()
            
            Text("Ops! Something went wrong. Try again!")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(Color.blue)
        }
    }
}

#Preview {
    ErrorView()
}
