//
//  UIView+Ext.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 19.01.2024.
//

import UIKit

extension UIView {
    func addShadow(ofColor color: UIColor = .black, radius: CGFloat = 8, offset: CGSize = .zero, opacity: Float = 0.4) {
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
}
