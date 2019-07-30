//
//  AddReviewViewController.swift
//  BookReview
//
//  Created by Andrew Kyong on 7/29/19.
//  Copyright © 2019 Andrew Kyong. All rights reserved.
//

import UIKit

protocol AddReviewViewControllerDelegate: class {
    func reviewDidAdd(_ addReviewViewController: AddReviewViewController, review: Review)
}

class AddReviewViewController: UIViewController {
    let book: Book
    var numOfStars = 0
    weak var delegate: AddReviewViewControllerDelegate?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starReview: StarReviewView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var reviewTextView: UITextView!

    init(book: Book) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
        self.title = "Write Review"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = book.name
        self.reviewTextView.layer.borderColor = UIColor.black.cgColor
        self.reviewTextView.layer.borderWidth = 1
        self.starReview.delegate = self
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        self.navigationItem.leftBarButtonItem = cancelButton
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        self.navigationItem.rightBarButtonItem = doneButton
    }

    @objc func cancelPressed() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func donePressed() {
        let review = Review(rating: self.numOfStars, review: self.reviewTextView.text)
        self.reviewTextView.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
        self.delegate?.reviewDidAdd(self, review: review)
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddReviewViewController: StarReviewDelegate {
    func reviewStarsDidGetPanned(_ starReviewView: StarReviewView, numOfStars: Int) {
        self.reviewTextView.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
        self.numOfStars = numOfStars
    }
}
