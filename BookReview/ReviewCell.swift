//
//  ReviewCell.swift
//  BookReview
//
//  Created by Andrew Kyong on 7/29/19.
//  Copyright © 2019 Andrew Kyong. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    @IBOutlet weak var starReview: StarReviewView!
    @IBOutlet weak var reviewText: UILabel!

    func configure(with review: Review){
        self.reviewText.text = review.review
        starReview.configure(with: review.rating)
    }
    
}
