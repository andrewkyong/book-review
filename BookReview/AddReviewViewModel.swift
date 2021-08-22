//
//  AddReviewViewModel.swift
//  BookReview
//
//  Created by Andrew Kyong on 8/21/21.
//  Copyright © 2021 Andrew Kyong. All rights reserved.
//

import Combine


class AddReviewViewModel: ViewModel {
    typealias ConfigurableView = AddReviewView

    let book: Book
    let doneCompletionHandler: () -> Void
    @Published var starCount = 0
    @Published var didPressDone = false
    @Published var reviewText = ""

    init(book: Book, doneCompletionHandler: @escaping () -> Void) {
        self.book = book
        self.doneCompletionHandler = doneCompletionHandler
    }    
}
