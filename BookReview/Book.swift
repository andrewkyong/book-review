//
//  File.swift
//  BookReview
//
//  Created by Andrew Kyong on 7/29/19.
//  Copyright © 2019 Andrew Kyong. All rights reserved.
//

import Foundation
import UIKit

class Book {
    var name: String
    var author: String
    var image: UIImage
    var reviews: [Review] = []

    init(name: String, author: String, image: UIImage) {
        self.name = name
        self.author = author
        self.image = image
    }
}
