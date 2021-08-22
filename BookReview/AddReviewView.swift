//
//  AddReviewView.swift
//  BookReview
//
//  Created by Andrew Kyong on 8/21/21.
//  Copyright © 2021 Andrew Kyong. All rights reserved.
//

import UIKit
import Combine

class AddReviewView: UIView, ConfigurableView {
    typealias ViewModel = AddReviewViewModel

    private let nameLabel = UILabel()
    private let starReview = StarReviewView()
    private let nameTextField  = UITextField()
    private let reviewTextView = UITextView()
    private let writingReviewForLabel = UILabel()

    private var model: ViewModel?
    private var numOfStars = 0
    private var doneCompletionHandler: () -> Void = {}
    private var cancellables: Set<AnyCancellable> = []


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews(views: [nameLabel, starReview, nameTextField, reviewTextView, writingReviewForLabel])
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        self.installConstraints()
    }

    func configure(with model: ViewModel) {
        self.nameLabel.text = model.book.name
        self.reviewTextView.layer.borderColor = UIColor.black.cgColor
        self.reviewTextView.layer.borderWidth = 1
        self.starReview.delegate = self
        self.starReview.configure(with: .init(reviewStarCount: model.starCount))
        self.writingReviewForLabel.text = "Writing Review For"
        self.nameTextField.placeholder = "Reviewer Name"
        self.model = model
        self.doneCompletionHandler = model.doneCompletionHandler
        bindViewModel(model: model)
    }

    private func bindViewModel(model: ViewModel) {
        model.$didPressDone.sink { [weak self] didPressDone in
            guard let self = self else { return }
            if didPressDone {
                self.reviewTextView.resignFirstResponder()
                self.nameTextField.resignFirstResponder()
                self.model?.reviewText = self.reviewTextView.text
                self.model?.starCount = self.numOfStars
                self.doneCompletionHandler()
            }
        }.store(in: &cancellables)
    }

    private func installConstraints() {
        let views = [
            "nameLabel": nameLabel,
            "starReview": starReview,
            "nameTextField": nameTextField,
            "reviewTextView": reviewTextView,
            "writingReviewForLabel": writingReviewForLabel,
        ]
        self.disablesAutoLayoutConstraints(views: views)
        
        var constraints: [NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-xlg-[writingReviewForLabel]-sm-[nameLabel]", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[nameLabel]-sm-[starReview]", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[starReview(70)]-sm-[reviewTextView(100)]-xs-[nameTextField(50)]->=lg-|", options: .alignAllCenterX, metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-lg-[writingReviewForLabel]", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-lg-[nameLabel]", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-lg-[reviewTextView(50)]-lg-|", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-lg-[starReview(200)]-lg-|", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-lg-[nameTextField(100)]-lg-|", metrics: PaddingMetrics.shared.metrics, views: views)
        constraints.activate()
    }

}

extension AddReviewView: StarReviewDelegate {
    func reviewStarsDidGetPanned(_ starReviewView: StarReviewView, numOfStars: Int) {
        self.reviewTextView.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
        self.model?.starCount = numOfStars
        self.numOfStars = numOfStars
    }
}

