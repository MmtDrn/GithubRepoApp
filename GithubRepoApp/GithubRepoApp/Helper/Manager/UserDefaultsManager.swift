//
//  UserDefaultsManager.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 18.01.2024.
//

import Foundation

struct UserDefaultsManager {
    static var userDefaults: UserDefaults = .standard
    private init() { }
    
    static func set<T>(_ value: T, forKey: String) where T: Encodable {
        if let encoded = try? JSONEncoder().encode(value) {
            userDefaults.set(encoded, forKey: forKey)
        }
    }
    
    static func get<T>(forKey: String) -> T? where T: Decodable {
        guard let data = userDefaults.value(forKey: forKey) as? Data,
            let decodedData = try? JSONDecoder().decode(T.self, from: data)
            else { return nil }
        return decodedData
    }
}
