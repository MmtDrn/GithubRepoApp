//
//  Router.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 18.01.2024.
//

import Foundation
import Alamofire

enum Router: EndpointConfiguration, CaseIterable {
    case algorand
    case perawallet
    case algorandfoundation
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .algorand:
            return "algorand/repos"
        case .perawallet:
            return "perawallet/repos"
        case .algorandfoundation:
            return "algorandfoundation/repos"
        }
    }
    
    var queryParameters: QueryStringParameters {
        return nil
    }
    
    var httpBody: Data? {
        return nil
    }
    
    var headers: [CustomHTTPHeader]? {
        return [.deviceType, .deviceId, .localization]
    }
    
    
}
