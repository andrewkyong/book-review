//
//  BookMockData.swift
//  BookReview
//
//  Created by Andrew Kyong on 8/20/21.
//  Copyright © 2021 Andrew Kyong. All rights reserved.
//

class MockData {
    public static var mockBooks: [Book] {
       return [Book(name: "7 Habits of Highly Effective People", author: "Stephen R. Covey", image: #imageLiteral(resourceName: "highly-effective"), reviews: mockReviews),
               Book(name: "Grit", author: "Angela Duckworth", image: #imageLiteral(resourceName: "grit"), reviews: mockReviews),
                     Book(name: "The Upstarts", author: "Brad Stone", image: #imageLiteral(resourceName: "upstarts"), reviews: mockReviews),
                     Book(name: "Elon Musk", author: "Ashlee Vance", image: #imageLiteral(resourceName: "elon"), reviews: mockReviews),
                     Book(name: "Shoe Dog", author: "Phil Knight", image: #imageLiteral(resourceName: "shoe-dog"), reviews: mockReviews)]
    }

    public static var mockReviews: [Review] {
        return [Review(rating: 5, review: "It was good"), Review(rating: 1, review: "It sucked")]
    }
}
