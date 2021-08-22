//
//  BookDetailsTableView.swift
//  BookReview
//
//  Created by Andrew Kyong on 8/20/21.
//  Copyright © 2021 Andrew Kyong. All rights reserved.
//

import UIKit

class BookDetailsTableView: UIView, ConfigurableView, UITableViewDataSource {
    typealias  ViewModel = BookDetailsTableViewModel

    private let bookAuthorLabel = UILabel()
    private let bookNameLabel = UILabel()
    private let reviewLabel = UILabel()
    private let bookImageView = UIImageView()
    private let addReviewButton = UIButton()
    private let reviewsTableView = UITableView()

    private var reviews: [Review] = []
    private var didTapAddReviewHandler: () -> Void = {}

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews(views: [bookAuthorLabel, bookNameLabel, bookImageView, addReviewButton, reviewsTableView, reviewLabel])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        self.installConstraints()
        self.reviewsTableView.reloadData()
    }
    
    func configure(with model: BookDetailsTableViewModel) {
        self.reviews = model.reviews
        self.bookAuthorLabel.text = "by \(model.book.author)"
        self.reviewLabel.text = "Reviews"
        self.bookNameLabel.text = model.book.name
        self.bookImageView.image = model.book.image
        self.addReviewButton.layer.borderColor = UIColor.black.cgColor
        self.addReviewButton.setTitle("Add Review", for: .normal)
        self.addReviewButton.setTitleColor(.blue, for: .normal)
        self.addReviewButton.layer.borderWidth = 1
        self.addReviewButton.layer.cornerRadius = 3
        self.reviewsTableView.dataSource = self
        self.reviewsTableView.tableFooterView = UIView()
        self.didTapAddReviewHandler = model.didTapAddReviewCompletionHandler
        self.addReviewButton.addTarget(self, action: #selector(didTapAddReviewButton), for: .touchUpInside)
        self.reviewsTableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.reuseIdentifier)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.reviewsTableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.reuseIdentifier) as? ReviewTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(with: reviews[indexPath.row])
        return cell
    }

    private func installConstraints() {
        let views = [
            "bookAuthorLabel": bookAuthorLabel,
            "bookNameLabel": bookNameLabel,
            "bookImageView": bookImageView,
            "addReviewButton": addReviewButton,
            "reviewsTableView": reviewsTableView,
            "reviewLabel": reviewLabel
        ]
        self.disablesAutoLayoutConstraints(views: views)
        var constraints: [NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-xlg-[bookImageView]-xlg-[reviewLabel]-lg-[reviewsTableView]-xlg-[addReviewButton]-sm-|", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[reviewsTableView]|", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[bookNameLabel]-sm-[bookAuthorLabel]", options: .alignAllLeading, metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[bookImageView]-sm-[bookNameLabel]->=lg-|", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-lg-[bookImageView]", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-lg-[reviewLabel]", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-lg-[addReviewButton]-lg-|", options: .alignAllCenterX, metrics: PaddingMetrics.shared.metrics, views: views)
        constraints.activate()
    }

    @objc func didTapAddReviewButton() {
        self.didTapAddReviewHandler()
    }
}
