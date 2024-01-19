//
//  HomeVC.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 18.01.2024.
//

import UIKit

class HomeVC: UIViewController {
    
    private var viewModel: HomeVM
    
    private lazy var segmentedButtonsView: SegmentedButtonsView = {
        let view = SegmentedButtonsView()
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(HomeVCCell.self, forCellReuseIdentifier: String(describing: HomeVCCell.self))
        tableView.showsVerticalScrollIndicator = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    init(viewModel: HomeVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        view.addSubview(tableView)
        
        segmentedButtonsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedButtonsView.snp.bottom).offset(10)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
}

// MARK: - Tableview methods
extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeVCCell.self), for: indexPath) as! HomeVCCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
