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
    @IBOutlet weak var addReviewButton: UIButton!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var reviewTableView: UITableView!
    weak var delegate: BookDetailViewControllerDelegate?
    var reviews = [Review(rating: 5, review: "It was good"), Review(rating: 1, review: "It sucked")]
    let book: Book

    init(book: Book) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
        self.title = book.name
        book.reviews = self.reviews
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookAuthor.text = "by \(book.author)"
        self.bookName.text = book.name
        self.bookImage.image = book.image
        self.addReviewButton.layer.borderColor = UIColor.black.cgColor
        self.addReviewButton.layer.borderWidth = 1
        self.addReviewButton.layer.cornerRadius = 3
        self.reviewTableView.dataSource = self
        self.reviewTableView.tableFooterView = UIView()
        self.addReviewButton.addTarget(self, action: #selector(addReviewButtonPressed), for: .touchUpInside)
        self.delegate?.reviewsDidUpdate(self, reviews: reviews)
        let nib = UINib(nibName: "ReviewCell", bundle: nil)
        self.reviewTableView.register(nib, forCellReuseIdentifier: "reuse")
    }

    @objc func addReviewButtonPressed() {
        let aRVC = AddReviewViewController(book: book)
        aRVC.delegate = self
        self.navigationController?.pushViewController(aRVC, animated: true)
    }
}

extension BookDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.reviewTableView.dequeueReusableCell(withIdentifier: "reuse") as! ReviewCell
        cell.selectionStyle = .none
        cell.configure(with: reviews[indexPath.row])
        return cell
    }
}

extension BookDetailViewController: AddReviewViewControllerDelegate {
    func reviewDidAdd(_ addReviewViewController: AddReviewViewController, review: Review) {
        reviews.append(review)
        self.reviewTableView.reloadData()
        self.delegate?.reviewsDidUpdate(self, reviews: reviews)
    }
}
