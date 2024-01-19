//
//  HomeVM.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 19.01.2024.
//

import Foundation

protocol HomeVMBinding: AnyObject {
    func reloadTableView()
}

class HomeVM {
    private var networkService: NetworkingProtocol
    weak var delegate: HomeVMBinding?
    var repos = [RepoModel]()
    
    init(networkService: NetworkingProtocol) {
        self.networkService = networkService
    }
    
    func getReposData() {
        for router in Router.allCases {
            networkService.request(router: router) { [weak self] (repo: [RepoModel]?, error) in
                guard let self, let repo else { return }
                print(repo.count)
                self.repos += repo
                self.delegate?.reloadTableView()
            }
        }
    }
}
