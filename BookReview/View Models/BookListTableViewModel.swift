//
//  BookListTableViewModel.swift
//  BookReview
//
//  Created by Andrew Kyong on 8/20/21.
//  Copyright © 2021 Andrew Kyong. All rights reserved.
//

import UIKit
import Combine

class BookListTableViewModel: ViewModel {
    typealias ConfigurableView = BookListTableView

    @Published var books: [Book] = []
    let selectedBookCompletionHandler: (Int) -> Void

    init(books: [Book], selectedBookCompletionHandler: @escaping (Int) -> Void) {
        self.books = books
        self.selectedBookCompletionHandler = selectedBookCompletionHandler
    }

}
