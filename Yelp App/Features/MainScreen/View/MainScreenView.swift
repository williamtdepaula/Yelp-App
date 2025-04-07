//
//  MainScreenView.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import SwiftUI

struct MainScreenView: View {
    
    @State private var searchText: String = "" // Need to be out of ViewModel to MainActor works correctly
    @StateObject private var viewModel: MainScreenViewModel
    
    init(mainScreenViewModel: MainScreenViewModel = MainScreenViewModel(searchBusiness: SearchBusiness(searchNetwork: SearchNetwork()))) {
        _viewModel = StateObject(wrappedValue: mainScreenViewModel)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
               Color.white
                   .ignoresSafeArea()

               mainView
                   .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
           }
        }
        .searchable(
            text: $searchText,
            prompt: "Look for a business",
            suggestions: {
                if viewModel.suggestionVisible {
                    ForEach(viewModel.autoCompleteOptions, id: \.self) { result in
                        Text(result)
                            .searchCompletion(result)
                    }
                }
            }
        )
        .onSubmit(of: .search) {
            viewModel.resetSearch(newTerm: searchText)
        }
        .onChange(of: searchText, { _, newValue in
            viewModel.onSearchChanged(newSearch: newValue)
        })
        .confirmationDialog("What do you want to do?", isPresented: $viewModel.actionSheetIsVisible, titleVisibility: .visible) {
            Button("Open in Safari") {
                if let selectedURL = viewModel.selectedURL {
                    UIApplication.shared.open(selectedURL)
                }
            }
            Button("Open in WebView") {
                viewModel.onPressToShowWebView()
            }
            Button("Cancel", role: .cancel) { viewModel.hideActionSheet() }
        }
        .sheet(isPresented: $viewModel.webViewIsVisible) {
            if let selectedURL = viewModel.selectedURL {
                WebView(selectedURL)
            }
        }
    }
    
    var mainView: some View {
        Group {
            switch viewModel.screenState {
            case .idle:
                EmptySearch(resultIsEmpty: false)
            case .loading:
                loadingView
            case .loadedSuccessfully, .loadingMore:
                resultView
            case .error:
                ErrorView()
            }
        }
    }
    
    var loadingView: some View {
        VStack {
            Spacer()
            Loading(scaleX: 2, scaleY: 2)
            Spacer()
        }
    }
    
    var resultView: some View {
        SearchList(
            state: viewModel.screenState == .loadingMore ? .loadingMore : .idle,
            searchText: viewModel.termSearched, businesses: viewModel.businesses,
            onPressItem: { data in
                viewModel.onPressItem(item: data)
            },
            onCardGetVisible: { data in
                viewModel.onCardGetVisible(cardData: data)
            }
        )
    }
}

#Preview {
    MainScreenView()
}
