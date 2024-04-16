//
//  SearchProfilesViewVM.swift
//  excursions
//
//  Created by Tobias Sörensson on 2024-02-29.
//

import SwiftUI

class SearchProfilesViewVM: ObservableObject {
    @Published var isEdit = false
    @Published var shouldNavigate = false
    
    let categories = SearchProfile.defaultProfiles
    
    func toggleIsEdit() {
        isEdit = !isEdit
        objectWillChange.send()
    }
    
    func buttonName() -> String {
        if isEdit {
            return "Cancel"
        } else {
            return "Edit"
        }
    }
}
