//
//  BookListTableView.swift
//  BookReview
//
//  Created by Andrew Kyong on 8/20/21.
//  Copyright © 2021 Andrew Kyong. All rights reserved.
//

import UIKit
import Combine

class BookListTableView: UIView, ConfigurableView, UITableViewDataSource, UITableViewDelegate {
    typealias ViewModel = BookListTableViewModel

    private var books: [Book] = []
    private var selectedBookCompletionHandler: (Int) -> Void = { _ in }
    private var cancellables: Set<AnyCancellable> = []
    private let bookListTableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(bookListTableView)
        self.bookListTableView.delegate = self
        self.bookListTableView.dataSource = self
        self.bookListTableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: BookListTableViewModel) {
        self.books = model.books
        self.selectedBookCompletionHandler = model.selectedBookCompletionHandler
        bindViewModel(model: model)
    }

    override func layoutSubviews() {
        self.bookListTableView.translatesAutoresizingMaskIntoConstraints = false
        self.bookListTableView.pinToSuperviewConstraints()
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.bookListTableView.dequeueReusableCell(withIdentifier: BookTableViewCell.reuseIdentifier) as? BookTableViewCell else { return UITableViewCell () }
        cell.configure(with: books[indexPath.row])
        return cell
    }

    private func bindViewModel(model: ViewModel) {
        model.$books.sink { [weak self] _ in
            self?.bookListTableView.reloadData()
        }.store(in: &cancellables)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedBookCompletionHandler(indexPath.row)
    }
}



