//
//  PaddingMetrics.swift
//  BookReview
//
//  Created by Andrew Kyong on 8/19/21.
//  Copyright © 2021 Andrew Kyong. All rights reserved.
//

import UIKit

class PaddingMetrics {
    public static var shared: PaddingMetrics = PaddingMetrics()
    var metrics: [String: Any] = [:]

    private init() {
        self.metrics = [
            "xs": 4,
            "sm": 8,
            "ms": 12,
            "md": 16,
            "lg": 24,
            "xlg": 36
        ]
    }
}

public extension Array where Element == NSLayoutConstraint {
    func activate() {
        _ = self.map { $0.isActive = true }
    }
}
