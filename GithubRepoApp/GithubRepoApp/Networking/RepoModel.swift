//
//  RepoModel.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 18.01.2024.
//

import Foundation

struct RepoModel: Codable {
    var id: Int?
    var name: String?
    var `private`: Bool?
    var owner: Owner?
    var html_url: String?
    var description: String?
    var fork: Bool?
    var url: String?
    var forks_url: String?
    var created_at: String?
    var updated_at: String?
    var pushed_at: String?
    var stargazers_count: Int?
    var watchers_count: Int?
    var forks_count: Int?
    var language: String?
    var svn_url: String?
}

struct Owner: Codable {
    var login: String?
    var id: Int?
    var node_id: String?
    var avatar_url: String?
    var gravatar_id: String?
    var url: String?
    var html_url: String?
    var followers_url: String?
    var following_url: String?
    var gists_url: String?
    var starred_url: String?
    var subscriptions_url: String?
    var organizations_url: String?
    var repos_url: String?
    var events_url: String?
    var received_events_url: String?
    var type: String?
    var site_admin: Bool?
}


