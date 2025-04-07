//
//  SearchList.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import SwiftUI

struct SearchList: View {
    enum SearchListStatus {
        case idle
        case loadingMore
    }
    
    let state: SearchListStatus
    let searchText: String
    let businesses: [Business]
    
    let onPressItem: ((Business) -> Void)?
    let onCardGetVisible: ((Business) -> Void)?
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8) {
            Text("Showing results for \(searchText)")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.black)
                .lineLimit(2)
                .padding(.leading, 12)
            
            
            if businesses.isEmpty {
                emptyView
            } else {
                List {
                    listView
                    
                    if state == .loadingMore {
                        loadingView
                    }
                }
                .listStyle(.plain)
            }
        }
    }
    
    var emptyView: some View {
        VStack {
            EmptySearch(resultIsEmpty: true)
            Spacer()
        }
    }
    
    var loadingView: some View {
        HStack {
            Spacer()
            Loading(scaleX: 1, scaleY: 1)
            Spacer()
        }
    }
    
    var listView: some View {
        ForEach(businesses, id: \.id) { data in
            BusinessCard(business: data)
                .listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 16, trailing: 12))
                .onTapGesture {
                    onPressItem?(data)
                }
                .onAppear {
                    onCardGetVisible?(data)
                }
        }
    }
}

#Preview {
    SearchList(
        state: .idle, searchText: "Test", businesses: [], onPressItem: nil, onCardGetVisible: nil
    )
}
