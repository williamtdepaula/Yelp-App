//
//  MainScreenViewModel.swift
//  Yelp App
//
//  Created by Willian de Paula on 06/04/25.
//

import Foundation

class MainScreenViewModel: ObservableObject {
    
    @Published var businesses: [Business] = []
    
    @Published var screenState: ScreenState = .idle
    
    @Published var actionSheetIsVisible: Bool = false
    
    @Published var webViewIsVisible: Bool = false
    
    @Published var suggestionVisible: Bool = false
    
    @Published var autoCompleteOptions: [String] = []
    
    var termSearched: String = ""
    
    private var currentItemPressed: Business?
    private var offsetSearch: Int = 0
    private var totalItems: Int = 0
    private let maxItemsPerSearch: Int = 20
    private var taskToGetAutoComplete: Task<(), Error>?
    
    var selectedURL: URL? {
        guard let urlString = currentItemPressed?.url else { return nil }
        return URL(string: urlString)
    }
    
    let searchBusiness: SearchBusinessProtocol
    
    init(searchBusiness: SearchBusinessProtocol) {
        self.searchBusiness = searchBusiness
    }
    
    func resetSearch(newTerm: String) {
        if newTerm != termSearched {
            autoCompleteOptions = []
            termSearched = newTerm
            offsetSearch = 0
            totalItems = 0
            search()
        }
    }
 
    func search(loadingMore: Bool = false) {
        suggestionVisible = false
        
        Task { [weak self] in
            guard let self, termSearched.count > 0 else { return }
            
            await MainActor.run { [weak self] in
                self?.screenState = !loadingMore ? .loading : .loadingMore
                
                if !loadingMore {
                    self?.businesses = []
                }
            }
            
            do {
                let search = try await searchBusiness.search(term: termSearched, offset: offsetSearch)
                
                offsetSearch += maxItemsPerSearch
                totalItems = search.total ?? search.businesses?.count ?? 0
                
                await MainActor.run { [weak self] in
                    self?.screenState = .loadedSuccessfully
                    self?.businesses += search.businesses ?? []
                }
            } catch {
                await MainActor.run { [weak self] in
                    // Case it's just loading more items we don't want to show error view
                    // Because we already have items rendered to user
                    self?.screenState = !loadingMore ? .error : .idle
                }
            }
        }
    }
    
    func getAutoCompleteOptions(newSearch: String) async -> [String] {
        let options = try? await searchBusiness.getAutoComplete(term: newSearch)
        
        return options ?? []
    }
    
    func onSearchChanged(newSearch: String) {
        suggestionVisible = newSearch != termSearched
        taskToGetAutoComplete?.cancel()
        
        guard !newSearch.isEmpty else {
            autoCompleteOptions = []
            return
        }
        
        taskToGetAutoComplete = Task {
            try await Task.sleep(seconds: 1)
            
            let options = await getAutoCompleteOptions(newSearch: newSearch)
            
            await MainActor.run { [weak self] in
                self?.autoCompleteOptions = options
            }
            
        }
    }
    
    func onPressItem(item: Business) {
        currentItemPressed = item
        actionSheetIsVisible = true
    }
    
    func hideActionSheet() {
        actionSheetIsVisible = false
    }
    
    func onPressToShowWebView() {
        webViewIsVisible = true
    }
    
    func onCardGetVisible(cardData: Business) {
        if cardData.id == businesses.last?.id, businesses.count < totalItems {
            search(loadingMore: true)
        }
    }
    
}
