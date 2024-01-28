//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 1/27/24.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
