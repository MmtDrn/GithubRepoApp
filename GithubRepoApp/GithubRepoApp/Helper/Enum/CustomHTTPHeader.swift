//
//  CustomHTTPHeader.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 17.01.2024.
//

import UIKit

enum CustomHTTPHeader: String {
    case authentication
    case contentType
    case multiPart
    case deviceId
    case deviceType
    case localization
    
    var key: String {
        switch self {
            case .authentication: return "Authorization"
            case .contentType: return "Content-Type"
            case .multiPart: return "Content-Type"
            case .deviceId: return "DeviceId"
            case .deviceType: return "DeviceType"
            case .localization: return "Localization"
        }
    }
    
    var value: String {
        switch self {
            case .authentication: return "Bearer " + ""
            case .contentType: return "application/json"
            case .multiPart: return "multipart/form-data"
            case .deviceId: return UIDevice.current.identifierForVendor!.uuidString
            case .deviceType: return "2"
            case .localization: return "en"
        }
    }
}
