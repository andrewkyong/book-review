//
//  BookDetailsTableViewModel.swift
//  BookReview
//
//  Created by Andrew Kyong on 8/20/21.
//  Copyright © 2021 Andrew Kyong. All rights reserved.
//

import Combine


class BookDetailsTableViewModel: ViewModel {
   typealias ConfigurableView = BookDetailsTableView

    let book: Book
    let didTapAddReviewCompletionHandler: () -> Void
    var reviews: [Review] = []


    init(book: Book, didTapAddReviewCompletionHandler: @escaping () -> Void) {
        self.book = book
        self.reviews = book.reviews
        self.didTapAddReviewCompletionHandler = didTapAddReviewCompletionHandler
    }
}
