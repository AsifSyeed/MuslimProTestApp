//
//  CommentsViewModel.swift
//  MuslimProTestApp
//
//  Created by Asif Reddot on 12/3/24.
//

import Foundation

class CommentsViewModel {
    private let item: HomeItemModel
    private(set) var comments: [CommentItemModel] = []
    
    init(item: HomeItemModel) {
        self.item = item
    }
    
    var title: String {
        return item.title
    }
    
    func addComment(_ text: String, by userName: String) {
        let comment = CommentItemModel(text: text, userName: userName, time: Date())
        comments.append(comment)
    }
}
