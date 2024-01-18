//
//  UserManager.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 18.01.2024.
//

import Foundation

protocol UserManagerProtecol {
    var isFirstLogin: Bool? { get set }
    var favRepos: [String]? { get set }
}

class UserManager: UserManagerProtecol {
    static let shared = UserManager()
    private init() { }
    
    var isFirstLogin: Bool? {
        get {
            return UserDefaultsManager.get(forKey: "isFirstLogin")
        }
        set {
            UserDefaultsManager.set(newValue, forKey: "isFirstLogin")
        }
    }
    
    var favRepos: [String]? {
        get {
            return UserDefaultsManager.get(forKey: "favRepos")
        }
        set {
            UserDefaultsManager.set(newValue, forKey: "favRepos")
        }
    }
}
