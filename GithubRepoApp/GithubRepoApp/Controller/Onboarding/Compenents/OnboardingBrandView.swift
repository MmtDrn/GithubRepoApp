//
//  OnboardingBrandView.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 17.01.2024.
//

import UIKit

class OnboardingBrandView: UIView {
    
    private lazy var brandTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .right
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var brandImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    convenience init(title: String, imageName: String) {
        self.init(frame: .zero)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        
        self.brandTitleLabel.text = title
        self.brandImageView.image = .init(named: imageName)
        
        addSubview(brandImageView)
        addSubview(brandTitleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        brandImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(80)
        }
        
        brandTitleLabel.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.trailing.equalTo(brandImageView.snp.leading).inset(-20)
        }
    }
}
