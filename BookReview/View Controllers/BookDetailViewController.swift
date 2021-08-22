//
//  BookDetailViewController.swift
//  BookReview
//
//  Created by Andrew Kyong on 7/29/19.
//  Copyright © 2019 Andrew Kyong. All rights reserved.
//

import UIKit

protocol BookDetailViewControllerDelegate: class {
    func reviewsDidUpdate(_ BookDetailViewController: BookDetailViewController, reviews: [Review])
}

class BookDetailViewController: UIViewController {

    weak var delegate: BookDetailViewControllerDelegate?
    let book: Book

    private var didTapAddReviewButtonCompletionHandler: () -> Void = {}
    private var viewModel: BookDetailsTableViewModel = BookDetailsTableViewModel(book: Book(name: "", author: "", image: .checkmark), didTapAddReviewCompletionHandler: {})

    init(book: Book) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
        self.title = book.name
        self.didTapAddReviewButtonCompletionHandler = { [weak self] in
            guard let self = self else { return }
            let vc = AddReviewViewController(book: book)
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        self.viewModel = BookDetailsTableViewModel(book: book, didTapAddReviewCompletionHandler: didTapAddReviewButtonCompletionHandler)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        _ = self.view.subviews.map { $0.removeFromSuperview() }
        self.view.backgroundColor = .white
        let view = BookDetailsTableView()
        view.configure(with: viewModel)
        self.view.addSubview(view)
        view.pinToSuperviewConstraints()
    }
}

extension BookDetailViewController: AddReviewViewControllerDelegate {
    func reviewDidAdd(_ addReviewViewController: AddReviewViewController, review: Review) {
        self.viewModel.reviews.append(review)
        self.delegate?.reviewsDidUpdate(self, reviews: viewModel.reviews)
    }
}
