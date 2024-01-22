//
//  HomeVCCell.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 19.01.2024.
//

import UIKit
import Kingfisher

class HomeVCCell: UITableViewCell {
    
    private lazy var ownerImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    
    private lazy var ownerNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = ""
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "GithubRepoApp"
        
        return label
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ownerImageView,
                                                       ownerNameLabel])
        
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        return stackView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "MVVM Design Pattern......blablabla"
        
        return label
    }()
    
    private lazy var starCountLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "⭐️ 3"
        
        return label
    }()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "🔴 Swift"
        
        return label
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [starCountLabel,
                                                       languageLabel])
        
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView,
                                                       nameLabel,
                                                       descriptionLabel,
                                                       bottomStackView])
        
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(containerStackView)
        
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        ownerImageView.snp.makeConstraints { make in
            make.height.width.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews(model: RepoModel) {
        ownerNameLabel.text = model.owner?.login?.capitalized
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        starCountLabel.text = "⭐️ \(model.stargazers_count ?? 0)"
        languageLabel.text = "🔴 \(model.language ?? "unkown language")"
        
        guard let avatarURL = model.owner?.avatar_url else { return }
        ownerImageView.kf.setImage(with: URL(string: avatarURL))
    }
}
