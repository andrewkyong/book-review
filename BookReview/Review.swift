//
//  Review.swift
//  BookReview
//
//  Created by Andrew Kyong on 7/29/19.
//  Copyright © 2019 Andrew Kyong. All rights reserved.
//

import Foundation

class Review {
    let rating: Int
    let review: String

    init(rating: Int, review: String) {
        self.rating = rating
        self.review = review
    }
}
