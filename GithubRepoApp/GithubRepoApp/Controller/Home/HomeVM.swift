//
//  HomeVM.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 19.01.2024.
//

import Foundation

protocol HomeVMBinding: AnyObject {
    
}

class HomeVM {
    private var networkService: NetworkingProtocol
    weak var delegate: HomeVM?
    
    init(networkService: NetworkingProtocol) {
        self.networkService = networkService
    }
}
