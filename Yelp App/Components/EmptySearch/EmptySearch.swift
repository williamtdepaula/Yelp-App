//
//  SearchBar.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import SwiftUI

struct EmptySearch: View {
    let resultIsEmpty: Bool
    
    var text: String {
        if resultIsEmpty {
            return "No results found"
        }
        
        return "Hey, you didn't enter anything to search"
    }
    
    var body: some View {
        VStack (alignment: .center) {
            if !resultIsEmpty {
                Image("curious")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .scaledToFit()
            }
            
            Text(text)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(Color.blue)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    EmptySearch(resultIsEmpty: false)
}
