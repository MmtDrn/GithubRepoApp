//
//  String+Ext.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 19.01.2024.
//

import UIKit

extension String {
    func getSize(font: UIFont = .boldSystemFont(ofSize: 12)) -> CGSize {
        
        let font = UIFont.boldSystemFont(ofSize: 12)
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        let size = (self as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
        
        return size
    }
}
