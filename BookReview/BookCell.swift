//
//  BookCell.swift
//  BookReview
//
//  Created by Andrew Kyong on 7/29/19.
//  Copyright © 2019 Andrew Kyong. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    @IBOutlet weak var bookStars: StarReviewView!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookImage: UIImageView!

    func configure(with book: Book){
        bookAuthor.text = "by \(book.author)"
        bookTitle.text = book.name
        bookImage.image = book.image
        if book.reviews.count == 0 {
            self.bookStars.configure(with: 0)
        } else {
            var average = 0
            for rating in book.reviews {
                average += rating.rating
            }
            average = Int(round(Double(average)/Double(book.reviews.count)))
            self.bookStars.configure(with: average)
        }
    }
}
