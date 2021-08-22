//
//  StarReviewViewModel .swift
//  BookReview
//
//  Created by Andrew Kyong on 8/19/21.
//  Copyright © 2021 Andrew Kyong. All rights reserved.
//

import UIKit

class StarReviewViewModel: ViewModel {
    typealias ConfigurableView = StarReviewView

    let reviewStarCount: Int

    init(reviewStarCount: Int) {
        self.reviewStarCount = reviewStarCount
    }
}

