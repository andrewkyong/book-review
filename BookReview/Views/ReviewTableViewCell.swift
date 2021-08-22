//
//  ReviewCell.swift
//  BookReview
//
//  Created by Andrew Kyong on 7/29/19.
//  Copyright © 2019 Andrew Kyong. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell, ConfigurableView {
    typealias ViewModel = Review

    static let reuseIdentifier = "ReviewTableViewCell"

    private let starReviewView = StarReviewView()
    private let reviewLabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubviews(views: [starReviewView, reviewLabel])
        self.installConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: Review) {
        self.reviewLabel.text = model.review
        let starReviewModel = StarReviewViewModel(reviewStarCount: model.rating)
        self.starReviewView.configure(with: starReviewModel)
    }

    private func installConstraints() {
        let views = [
            "starReviewView": starReviewView,
            "reviewLabel": reviewLabel
        ]
        self.disablesAutoLayoutConstraints(views: views)
        var constraints: [NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-sm-[starReviewView]-lg-[reviewLabel]->=md-|", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-md-[starReviewView]->=md-|", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-md-[reviewLabel]->=md-|", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints.activate()
    }
}
