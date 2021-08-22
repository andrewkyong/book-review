//
//  AddReviewViewController.swift
//  BookReview
//
//  Created by Andrew Kyong on 7/29/19.
//  Copyright © 2019 Andrew Kyong. All rights reserved.
//

import UIKit

protocol AddReviewViewControllerDelegate: class {
    func reviewDidAdd(_ addReviewViewController: AddReviewViewController, review: Review)
}

class AddReviewViewController: UIViewController {
    private let book: Book
    weak var delegate: AddReviewViewControllerDelegate?
    private var viewModel: AddReviewViewModel = AddReviewViewModel(book: Book(name: "", author: "", image: .init()), doneCompletionHandler: {})

    init(book: Book) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
        self.title = "Write Review"
        let view = AddReviewView()
        self.viewModel =  AddReviewViewModel(
            book: book,
            doneCompletionHandler: { [weak self] in
                guard let self = self else { return }
                let review = Review(rating: self.viewModel.starCount, review: self.viewModel.reviewText)
                self.delegate?.reviewDidAdd(self, review: review)
                self.navigationController?.popViewController(animated: true)
            }
        )
        view.configure(with: viewModel)
        self.view.addSubview(view)
        view.pinToSuperviewConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        self.navigationItem.leftBarButtonItem = cancelButton
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        self.navigationItem.rightBarButtonItem = doneButton
        self.view.backgroundColor = .white
    }

    @objc func cancelPressed() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func donePressed() {
        self.viewModel.didPressDone = true
    }
}
