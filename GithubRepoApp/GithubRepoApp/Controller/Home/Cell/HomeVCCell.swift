//
//  HomeVCCell.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 19.01.2024.
//

import UIKit

class HomeVCCell: UITableViewCell {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "GithubRepoApp"
        
        return label
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
        let stackView = UIStackView(arrangedSubviews: [nameLabel,
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews(model: RepoModel) {
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        starCountLabel.text = "⭐️ \(model.stargazers_count ?? 0)"
        languageLabel.text = "🔴 \(model.language ?? "unkown language")"
    }
}
