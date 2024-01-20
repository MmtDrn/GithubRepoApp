//
//  HomeVC.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 18.01.2024.
//

import UIKit

class HomeVC: UIViewController {
    
    private var viewModel: HomeVM
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.placeholder = "Search"
        searchBar.isHidden = true
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        
        return searchBar
    }()
    
    private lazy var segmentedButtonsView: SegmentedButtonsView = {
        let view = SegmentedButtonsView()
        
        view.delegate = self
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(HomeVCCell.self, forCellReuseIdentifier: String(describing: HomeVCCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    init(viewModel: HomeVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "Repositories"
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(searchButtonTapped))
        
        setupViews()
        viewModel.getReposData()
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
    
    @objc func searchButtonTapped() {
        segmentedButtonsView.reConfigureButtons()
        searchBar.isHidden = false
        searchBar.becomeFirstResponder()
    }
}

// MARK: - Searchbar delegate
extension HomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterBySearchBar(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.isHidden = true
        searchBar.text = ""
        viewModel.resetList()

    }
}

// MARK: - Filter logics
extension HomeVC: FilterProtocol {
    func sendFiletCase(filterCase: FilterCases) {
        viewModel.filterList(filterCase)
    }
}

// MARK: - ViewModel subscribe logics
extension HomeVC: HomeVMBinding {
    func reloadTableView() {
        tableView.reloadData()
    }
}

// MARK: - Tableview methods
extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeVCCell.self), for: indexPath) as! HomeVCCell
        let repo = viewModel.filteredList[indexPath.row]
        
        cell.configureViews(model: repo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let repoURL = viewModel.filteredList[indexPath.row].svn_url else { return }
        let webViewVC = WebViewVC(urlString: repoURL)
        navigationController?.pushViewController(webViewVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
