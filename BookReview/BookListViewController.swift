//
//  BookListViewController.swift
//  BaseExam
//
//  Created by Andrew Kyong on 7/29/19.
//  Copyright © 2019 Andrew Kyong. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController {
    @IBOutlet weak var bookTableView: UITableView!
    var books: [Book] = []
    var selected: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List of Books"
        self.view.backgroundColor = UIColor.white
        self.books = [Book(name: "7 Habits of Highly Effective People", author: "Stephen R. Covey", image: #imageLiteral(resourceName: "highly-effective")),
                      Book(name: "Grit", author: "Angela Duckworth", image: #imageLiteral(resourceName: "grit")),
                      Book(name: "The Upstarts", author: "Brad Stone", image: #imageLiteral(resourceName: "upstarts")),
                      Book(name: "Elon Musk", author: "Ashlee Vance", image: #imageLiteral(resourceName: "elon")),
                      Book(name: "Shoe Dog", author: "Phil Knight", image: #imageLiteral(resourceName: "shoe-dog"))]
        let nib = UINib(nibName: "BookCell", bundle: nil)
        self.bookTableView.register(nib, forCellReuseIdentifier: "habitat")
        self.bookTableView.dataSource = self
        self.bookTableView.delegate = self
        }
}

extension BookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.bookTableView.dequeueReusableCell(withIdentifier: "habitat") as! BookCell
        cell.configure(with: books[indexPath.row])
        return cell
    }
}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bDVC = BookDetailViewController(book: books[indexPath.row])
        selected = indexPath.row
        bDVC.delegate = self
        self.navigationController?.pushViewController(bDVC, animated: true)
    }
}

extension BookListViewController: BookDetailViewControllerDelegate {
    func reviewsDidUpdate(_ BookDetailViewController: BookDetailViewController, reviews: [Review]) {
        self.books[selected].reviews = reviews
        self.bookTableView.reloadData()
    }

}

