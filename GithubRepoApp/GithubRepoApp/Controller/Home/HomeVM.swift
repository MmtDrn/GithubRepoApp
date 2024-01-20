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
    private var filters = [FilterCases]()
    
    private var brands: [FilterCases] = [.algorand, .peraWallet, .algorandFoundatiton, .allBrand]
    private var languages: [FilterCases] = [.swift, .python, .go, .allLaunguage]
    private var dateParams: [FilterCases] = [.recentlyPushed, .latestPushed, .newest, .oldest]
    
        
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
    
    func filterList(_ filterCase: FilterCases) {
        updatedFilters(filterCase)
        
        for index in 0..<filters.count {
            if index == 0 {
                filteredList = filtersLogic(filterCase: filters[index], repoList: pureList)
            } else {
                filteredList = filtersLogic(filterCase: filters[index], repoList: filteredList)
            }
        }
        
        delegate?.reloadTableView()
    }
    
    private func updatedFilters(_ filterCase: FilterCases) {
        if brands.contains(filterCase) {
            if filterCase == .allBrand {
                removeFilters(for: brands)
            } else {
                removeFilters(for: brands)
                filters.append(filterCase)
            }
        } else if languages.contains(filterCase) {
            if filterCase == .allLaunguage {
                removeFilters(for: languages)
            } else {
                removeFilters(for: languages)
                filters.append(filterCase)
            }
        } else if dateParams.contains(filterCase) {
            removeFilters(for: dateParams)
            filters.append(filterCase)
        }
    }
    
    private func removeFilters(for filterList: [FilterCases]) {
        filterList.forEach { filter in
            if filters.contains(filter), let index = filters.firstIndex(of: filter) {
                filters.remove(at: index)
            }
        }
    }
    
    private func filtersLogic(filterCase: FilterCases, repoList: [RepoModel]) -> [RepoModel] {
        var newRepoList = [RepoModel]()
        
        switch filterCase {
        case .peraWallet:
            newRepoList = repoList.filter{ $0.owner?.login == "perawallet" }
        case .algorand:
            newRepoList = repoList.filter{ $0.owner?.login == "algorand" }
        case .algorandFoundatiton:
            newRepoList = repoList.filter{ $0.owner?.login == "algorandfoundation" }
        case .swift:
            newRepoList = repoList.filter{ $0.language?.capitalized == "Swift".capitalized }
        case .python:
            newRepoList = repoList.filter{ $0.language?.capitalized == "Python".capitalized }
        case .go:
            newRepoList = repoList.filter{ $0.language?.capitalized == "Go".capitalized }
        case .recentlyPushed:
            newRepoList = repoList.sorted {
                guard let date1 = $0.pushed_at?.toDate(),
                      let date2 = $1.pushed_at?.toDate() else { return false }
                
                return date1 > date2
            }
        case .latestPushed:
            newRepoList = repoList.sorted {
                guard let date1 = $0.pushed_at?.toDate(),
                      let date2 = $1.pushed_at?.toDate() else { return false }
                
                return date1 < date2
            }
        case .newest:
            newRepoList = repoList.sorted {
                guard let date1 = $0.created_at?.toDate(),
                      let date2 = $1.created_at?.toDate() else { return false }
                
                return date1 > date2
            }
        case .oldest:
            newRepoList = repoList.sorted {
                guard let date1 = $0.created_at?.toDate(),
                      let date2 = $1.created_at?.toDate() else { return false }
                
                return date1 < date2
            }
        default: break
        }
        
        return newRepoList
    }
    
    func filterBySearchBar(_ text: String) {
        if !text.isEmpty {
            filteredList = pureList.filter { $0.name!.lowercased().contains(text.lowercased()) }
            delegate?.reloadTableView()
        } else {
            resetList()
        }
    }
    
    func resetList() {
        filteredList = pureList
        delegate?.reloadTableView()
    }
}
