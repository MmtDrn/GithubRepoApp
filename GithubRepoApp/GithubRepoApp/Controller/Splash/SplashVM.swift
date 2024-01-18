//
//  SplashVM.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 18.01.2024.
//

import Foundation

class SplashVM {
    let userManager: UserManagerProtecol
    
    init(userManager: UserManagerProtecol) {
        self.userManager = userManager
    }
    
    func firstLogin() -> Bool {
        guard let hasLogin = userManager.isFirstLogin else {
            return true
        }
        return hasLogin
    }
}
