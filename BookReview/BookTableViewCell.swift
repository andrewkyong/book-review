//
//  BookTableViewCell.swift
//  BookReview
//
//  Created by Andrew Kyong on 7/29/19.
//  Copyright © 2019 Andrew Kyong. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell, ConfigurableView {
    typealias ViewModel = Book

    static let reuseIdentifier = "BookTableViewCell"
    private let starReviewView = StarReviewView()
    private let bookAuthorLabel = UILabel()
    private let bookTitleLabel = UILabel()
    private let bookImageView = UIImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubviews(views: [starReviewView, bookAuthorLabel, bookTitleLabel, bookImageView])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: ViewModel) {
        self.addSubviews(views: [starReviewView, bookAuthorLabel, bookTitleLabel, bookImageView])
        self.installConstraints()
        bookAuthorLabel.text = "by \(model.author)"
        bookTitleLabel.text = model.name
        bookTitleLabel.numberOfLines = 0
        bookImageView.image = model.image
        if model.reviews.count == 0 {
            let starReviewModel = StarReviewViewModel(reviewStarCount: 0)
            self.starReviewView.configure(with: starReviewModel)
        } else {
            var average = 0
            for rating in model.reviews {
                average += rating.rating
            }
            average = Int(round(Double(average)/Double(model.reviews.count)))
            let starReviewModel = StarReviewViewModel(reviewStarCount: average)
            self.starReviewView.configure(with: starReviewModel)
        }
    }

    private func installConstraints() {
        let views = [
            "starReviewView": starReviewView,
            "bookAuthorLabel": bookAuthorLabel,
            "bookTitleLabel": bookTitleLabel,
            "bookImageView": bookImageView
        ]
        self.disablesAutoLayoutConstraints(views: views)
        var constraints: [NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-sm-[bookImageView]-sm-|", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-md-[bookTitleLabel]-sm-[bookAuthorLabel]-sm-[starReviewView]", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-lg-[bookImageView(90)]-sm-[bookAuthorLabel]", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[bookImageView]-sm-[bookTitleLabel]->=md-|", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[bookImageView]-sm-[starReviewView]->=md-|", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += [bookImageView.widthAnchor.constraint(equalTo: bookImageView.heightAnchor, multiplier: CGFloat(49.0/64.0))]
        constraints.activate()
    }
}
