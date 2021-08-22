//
//  BookListViewController.swift
//  BaseExam
//
//  Created by Andrew Kyong on 7/29/19.
//  Copyright © 2019 Andrew Kyong. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController {

    private var selectedIndexPathRow: Int = 0
    private var selectedBookCompletionHandler: (Int) -> Void = { _ in }
    private var viewModel: BookListTableViewModel = BookListTableViewModel(books: [], selectedBookCompletionHandler: { _ in })

    init(books: [Book] = MockData.mockBooks) {
        super.init(nibName: nil, bundle: nil)
        self.selectedBookCompletionHandler = { [weak self] indexPathRow in
            guard let self = self else { return }
            let vc = BookDetailViewController(book: self.viewModel.books[indexPathRow])
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
            self.selectedIndexPathRow = indexPathRow
        }
        self.viewModel = BookListTableViewModel(books: books, selectedBookCompletionHandler: selectedBookCompletionHandler)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List of Books"
    }

    override func viewDidAppear(_ animated: Bool) {
        _ = self.view.subviews.map { $0.removeFromSuperview() }
        self.view.backgroundColor = .white
        let bookListView = BookListTableView()
        bookListView.configure(with: viewModel)
        self.view.addSubview(bookListView)
        bookListView.pinToSuperviewConstraints()
    }
}

extension BookListViewController: BookDetailViewControllerDelegate {
    func reviewsDidUpdate(_ BookDetailViewController: BookDetailViewController, reviews: [Review]) {
        viewModel.books[selectedIndexPathRow].reviews = reviews
    }

}
