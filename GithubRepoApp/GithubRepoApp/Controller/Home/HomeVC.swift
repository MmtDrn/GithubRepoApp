//
//  HomeVC.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 18.01.2024.
//

import UIKit

class HomeVC: UIViewController {
    
    private lazy var segmentedButtonsView: SegmentedButtonsView = {
        let view = SegmentedButtonsView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.title = "Repositories"
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(segmentedButtonsView)
        segmentedButtonsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
    }
}
