//
//  ConfigurableView+Protocols.swift
//  BookReview
//
//  Created by Andrew Kyong on 8/20/21.
//  Copyright © 2021 Andrew Kyong. All rights reserved.
//

import UIKit

protocol ConfigurableView: UIView {
    associatedtype ViewModel

    func configure(with model: ViewModel)

  //  init(with model: ViewModel)
}

extension ConfigurableView {
    func disablesAutoLayoutConstraints(views: [String: UIView]) {
        _ = views.map { $1.translatesAutoresizingMaskIntoConstraints = false }
    }
}

public extension UIView {
    func pinToSuperviewConstraints(insets: UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let superView = self.superview else { return }
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: insets.left).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: insets.right).isActive = true
        self.topAnchor.constraint(equalTo: superView.topAnchor, constant: insets.top).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -insets.bottom).isActive = true

    }

    func addSubviews(views: [UIView]) {
        _ = views.map { self.addSubview($0) }
    }
}
