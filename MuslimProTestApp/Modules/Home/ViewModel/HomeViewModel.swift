//
//  HomeViewModel.swift
//  MuslimProTestApp
//
//  Created by Asif Reddot on 12/3/24.
//

import Foundation

class HomeViewModel {
    
    private(set) var items: [HomeItemModel] = []
    
    func fetchItems() {
        items = [
            HomeItemModel(title: "Item 1", subtitle: "Subtitle 1"),
            HomeItemModel(title: "Item 2", subtitle: "Subtitle 2"),
            HomeItemModel(title: "Item 3", subtitle: "Subtitle 3"),
            HomeItemModel(title: "Item 4", subtitle: "Subtitle 4"),
            HomeItemModel(title: "Item 5", subtitle: "Subtitle 5")
        ]
    }
}
