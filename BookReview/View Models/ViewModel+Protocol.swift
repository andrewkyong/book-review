//
//  ViewModelProtocol.swift
//  BookReview
//
//  Created by Andrew Kyong on 8/19/21.
//  Copyright © 2021 Andrew Kyong. All rights reserved.
//

import UIKit

protocol ViewModel {
    associatedtype ConfigurableView: UIView

}

extension ViewModel {
    func makeView() -> UIView {
     //   return Self.ConfigurableView.init(with model: Self)
        return Self.ConfigurableView.init()
    }
}
