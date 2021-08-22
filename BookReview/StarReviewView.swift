//
//  StarSwipeView.swift
//  BookReview
//
//  Created by Andrew Kyong on 7/29/19.
//  Copyright © 2019 Andrew Kyong. All rights reserved.
//

import UIKit

protocol StarReviewDelegate: class {
    func reviewStarsDidGetPanned(_ starReviewView: StarReviewView, numOfStars: Int)
}

class StarReviewView: UIView, ConfigurableView {
    typealias ViewModel = StarReviewViewModel

    private let firstStarImageView = UIImageView(image: #imageLiteral(resourceName: "star-empty-icon"))
    private let secondStarImageView = UIImageView(image: #imageLiteral(resourceName: "star-empty-icon"))
    private let thirdStarImageView = UIImageView(image: #imageLiteral(resourceName: "star-empty-icon"))
    private let fourthStarImageView = UIImageView(image: #imageLiteral(resourceName: "star-empty-icon"))
    private let fifthStarImageView = UIImageView(image: #imageLiteral(resourceName: "star-empty-icon"))
    private var numberOfStars = 0
    private let nonHighlightedStarImage = #imageLiteral(resourceName: "star-empty-icon")
    private let highlightedStarImage = #imageLiteral(resourceName: "star-icon")

    weak var delegate: StarReviewDelegate?

    private let squareImageHeight: CGFloat = 25.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews(views: [firstStarImageView, secondStarImageView, thirdStarImageView, fourthStarImageView, fifthStarImageView])
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture))
        self.addGestureRecognizer(panGesture)
        self.isUserInteractionEnabled = true 
        self.firstStarImageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        self.secondStarImageView.frame = CGRect(x: self.firstStarImageView.frame.maxX + 3, y: 0, width: squareImageHeight, height: squareImageHeight)
        self.thirdStarImageView.frame = CGRect(x: self.secondStarImageView.frame.maxX + 3, y: 0, width: squareImageHeight, height: squareImageHeight)
        self.fourthStarImageView.frame = CGRect(x: self.thirdStarImageView.frame.maxX + 3, y: 0, width: squareImageHeight, height: squareImageHeight)
        self.fifthStarImageView.frame = CGRect(x: self.fourthStarImageView.frame.maxX + 3, y: 0, width: squareImageHeight, height: squareImageHeight)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: ViewModel) {
        self.numberOfStars = model.reviewStarCount
        self.layoutStars()
    }

    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)

        if translation.x >= self.firstStarImageView.frame.maxX {
            numberOfStars = 1
        }
        if translation.x >= self.secondStarImageView.frame.maxX {
            numberOfStars = 2
        }
        if translation.x >= self.thirdStarImageView.frame.maxX {
            numberOfStars = 3
        }
        if translation.x >= self.fourthStarImageView.frame.maxX {
            numberOfStars = 4
        }
        if translation.x >= self.fifthStarImageView.frame.maxX {
            numberOfStars = 5
        }
        if translation.x <= self.fifthStarImageView.frame.minX {
            numberOfStars = 4
        }
        if translation.x <= self.fourthStarImageView.frame.minX {
            numberOfStars = 3
        }
        if translation.x <= self.thirdStarImageView.frame.minX {
            numberOfStars = 2
        }
        if translation.x <= self.secondStarImageView.frame.minX {
            numberOfStars = 1
        }
        if translation.x <= self.firstStarImageView.frame.minX {
            numberOfStars = 0
        }
        self.layoutStars()
        if sender.state == .ended {
            self.delegate?.reviewStarsDidGetPanned(self, numOfStars: numberOfStars)
        }
    }

    private func layoutStars() {
        if numberOfStars == 0 {
            self.firstStarImageView.image = nonHighlightedStarImage
            self.secondStarImageView.image = nonHighlightedStarImage
            self.thirdStarImageView.image = nonHighlightedStarImage
            self.fourthStarImageView.image = nonHighlightedStarImage
            self.fifthStarImageView.image = nonHighlightedStarImage
        } else if numberOfStars == 1 {
            self.firstStarImageView.image = highlightedStarImage
            self.secondStarImageView.image = nonHighlightedStarImage
            self.thirdStarImageView.image = nonHighlightedStarImage
            self.fourthStarImageView.image = nonHighlightedStarImage
            self.fifthStarImageView.image = nonHighlightedStarImage
        } else if numberOfStars == 2 {
            self.firstStarImageView.image = highlightedStarImage
            self.secondStarImageView.image = highlightedStarImage
            self.thirdStarImageView.image = nonHighlightedStarImage
            self.fourthStarImageView.image = nonHighlightedStarImage
            self.fifthStarImageView.image = nonHighlightedStarImage
        } else if numberOfStars == 3 {
            self.firstStarImageView.image = highlightedStarImage
            self.secondStarImageView.image = highlightedStarImage
            self.thirdStarImageView.image = highlightedStarImage
            self.fourthStarImageView.image = nonHighlightedStarImage
            self.fifthStarImageView.image = nonHighlightedStarImage
        } else if numberOfStars == 4 {
            self.firstStarImageView.image = highlightedStarImage
            self.secondStarImageView.image = highlightedStarImage
            self.thirdStarImageView.image = highlightedStarImage
            self.fourthStarImageView.image = highlightedStarImage
            self.fifthStarImageView.image = nonHighlightedStarImage
        } else if numberOfStars == 5 {
            self.firstStarImageView.image = highlightedStarImage
            self.secondStarImageView.image = highlightedStarImage
            self.thirdStarImageView.image = highlightedStarImage
            self.fourthStarImageView.image = highlightedStarImage
            self.fifthStarImageView.image = highlightedStarImage
        }
        self.layoutIfNeeded()
    }
}
