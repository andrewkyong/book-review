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

class StarReviewView: UIView {
    var firstStar = UIImageView(image: #imageLiteral(resourceName: "star-empty-icon"))
    var secondStar = UIImageView(image: #imageLiteral(resourceName: "star-empty-icon"))
    var thirdStar = UIImageView(image: #imageLiteral(resourceName: "star-empty-icon"))
    var fourthStar = UIImageView(image: #imageLiteral(resourceName: "star-empty-icon"))
    var fifthStar = UIImageView(image: #imageLiteral(resourceName: "star-empty-icon"))
    var numberOfStars = 0
    weak var delegate: StarReviewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        
        if translation.x >= self.firstStar.frame.maxX {
            numberOfStars = 1
        }
        if translation.x >= self.secondStar.frame.maxX {
            numberOfStars = 2
        }
        if translation.x >= self.thirdStar.frame.maxX {
            numberOfStars = 3
        }
        if translation.x >= self.fourthStar.frame.maxX {
            numberOfStars = 4
        }
        if translation.x >= self.fifthStar.frame.maxX {
            numberOfStars = 5
        }
        if translation.x <= self.fifthStar.frame.minX {
            numberOfStars = 4
        }
        if translation.x <= self.fourthStar.frame.minX {
            numberOfStars = 3
        }
        if translation.x <= self.thirdStar.frame.minX {
            numberOfStars = 2
        }
        if translation.x <= self.secondStar.frame.minX {
            numberOfStars = 1
        }
        if translation.x <= self.firstStar.frame.minX {
            numberOfStars = 0
        }
        self.layoutStars()
        if sender.state == .ended {
            self.delegate?.reviewStarsDidGetPanned(self, numOfStars: numberOfStars)
        }
    }

    func configure(with starCount: Int){
        self.numberOfStars = starCount
        self.layoutStars()
    }

    func layoutStars() {
        if numberOfStars == 0 {
            self.firstStar.image = #imageLiteral(resourceName: "star-empty-icon")
            self.secondStar.image = #imageLiteral(resourceName: "star-empty-icon")
            self.thirdStar.image = #imageLiteral(resourceName: "star-empty-icon")
            self.fourthStar.image = #imageLiteral(resourceName: "star-empty-icon")
            self.fifthStar.image = #imageLiteral(resourceName: "star-empty-icon")
        }
        if numberOfStars == 1 {
            self.firstStar.image = #imageLiteral(resourceName: "star-icon")
            self.secondStar.image = #imageLiteral(resourceName: "star-empty-icon")
            self.thirdStar.image = #imageLiteral(resourceName: "star-empty-icon")
            self.fourthStar.image = #imageLiteral(resourceName: "star-empty-icon")
            self.fifthStar.image = #imageLiteral(resourceName: "star-empty-icon")
        }
        if numberOfStars == 2 {
            self.firstStar.image = #imageLiteral(resourceName: "star-icon")
            self.secondStar.image = #imageLiteral(resourceName: "star-icon")
            self.thirdStar.image = #imageLiteral(resourceName: "star-empty-icon")
            self.fourthStar.image = #imageLiteral(resourceName: "star-empty-icon")
            self.fifthStar.image = #imageLiteral(resourceName: "star-empty-icon")
        }
        if numberOfStars == 3 {
            self.firstStar.image = #imageLiteral(resourceName: "star-icon")
            self.secondStar.image = #imageLiteral(resourceName: "star-icon")
            self.thirdStar.image = #imageLiteral(resourceName: "star-icon")
            self.fourthStar.image = #imageLiteral(resourceName: "star-empty-icon")
            self.fifthStar.image = #imageLiteral(resourceName: "star-empty-icon")
        }
        if numberOfStars == 4 {
            self.firstStar.image = #imageLiteral(resourceName: "star-icon")
            self.secondStar.image = #imageLiteral(resourceName: "star-icon")
            self.thirdStar.image = #imageLiteral(resourceName: "star-icon")
            self.fourthStar.image = #imageLiteral(resourceName: "star-icon")
            self.fifthStar.image = #imageLiteral(resourceName: "star-empty-icon")
        }
        if numberOfStars == 5 {
            self.firstStar.image = #imageLiteral(resourceName: "star-icon")
            self.secondStar.image = #imageLiteral(resourceName: "star-icon")
            self.thirdStar.image = #imageLiteral(resourceName: "star-icon")
            self.fourthStar.image = #imageLiteral(resourceName: "star-icon")
            self.fifthStar.image = #imageLiteral(resourceName: "star-icon")
        }
        self.layoutIfNeeded()
    }

    private func commonInit() {
        self.addSubview(firstStar)
        self.addSubview(secondStar)
        self.addSubview(thirdStar)
        self.addSubview(fourthStar)
        self.addSubview(fifthStar)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture))
        self.addGestureRecognizer(panGesture)
        self.firstStar.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        self.secondStar.frame = CGRect(x: self.firstStar.frame.maxX + 3, y: 0, width: 25, height: 25)
        self.thirdStar.frame = CGRect(x: self.secondStar.frame.maxX + 3, y: 0, width: 25, height: 25)
        self.fourthStar.frame = CGRect(x: self.thirdStar.frame.maxX + 3, y: 0, width: 25, height: 25)
        self.fifthStar.frame = CGRect(x: self.fourthStar.frame.maxX + 3, y: 0, width: 25, height: 25)

    }
}
