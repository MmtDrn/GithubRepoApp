//
//  UserManager.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 18.01.2024.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    private init() { }
    
    var isFirstLogin: Bool? {
        get {
            return UserDefaultsManager.get(forKey: "isFirstLogin")
        }
        set {
            UserDefaultsManager.userDefaults.set(newValue, forKey: "isFirstLogin")
        }
    }
    
    var favRepos: [String]? {
        get {
            return UserDefaultsManager.get(forKey: "favRepos")
        }
        set {
            UserDefaultsManager.userDefaults.set(newValue, forKey: "favRepos")
        }
    }
}
