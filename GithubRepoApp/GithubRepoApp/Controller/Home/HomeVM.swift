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
    
    var pureList = [RepoModel]()
    var filteredList = [RepoModel]()
        
    init(networkService: NetworkingProtocol) {
        self.networkService = networkService
    }
    
    func getReposData() {
        for router in Router.allCases {
            networkService.request(router: router) { [weak self] (repo: [RepoModel]?, error) in
                guard let self, let repo else { return }
                self.pureList += repo
                self.filteredList += repo
                self.delegate?.reloadTableView()
            }
        }
    }
    
    func filtreList(_ filterCase: FilterCases) {
        #warning("filter methods will update")
        switch filterCase {
        case .allBrand:
            filteredList = pureList
        case .peraWallet:
            filteredList = pureList.filter{ $0.owner?.login == "perawallet" }
        case .algorand:
            filteredList = pureList.filter{ $0.owner?.login == "algorand" }
        case .algorandFoundatiton:
            filteredList = pureList.filter{ $0.owner?.login == "algorandfoundation" }
        case .allLaunguage:
            filteredList = pureList
        case .swift:
            filteredList = pureList.filter{ $0.language?.capitalized == "Swift".capitalized }
        case .python:
            filteredList = pureList.filter{ $0.language?.capitalized == "Python".capitalized }
        case .go:
            filteredList = pureList.filter{ $0.language?.capitalized == "Go".capitalized }
        case .recentlyPushed:
            filteredList = pureList.sorted {
                guard let date1 = $0.pushed_at?.toDate(),
                      let date2 = $1.pushed_at?.toDate() else { return false }
                
                return date1 > date2
            }
        case .latestPushed:
            filteredList = pureList.sorted {
                guard let date1 = $0.pushed_at?.toDate(),
                      let date2 = $1.pushed_at?.toDate() else { return false }
                
                return date1 < date2
            }
        case .newest:
            filteredList = pureList.sorted {
                guard let date1 = $0.created_at?.toDate(),
                      let date2 = $1.created_at?.toDate() else { return false }
                
                return date1 > date2
            }
        case .oldest:
            filteredList = pureList.sorted {
                guard let date1 = $0.created_at?.toDate(),
                      let date2 = $1.created_at?.toDate() else { return false }
                
                return date1 < date2
            }
        }
        delegate?.reloadTableView()
    }
}
