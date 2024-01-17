//
//  NetworkError.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 17.01.2024.
//

import Foundation

enum NetworkError {
    case noError
    case credentialsWrong
    case notConnectedInternet
    case serviceResponseFailed
    case conflictCredentials
    case emptyOrNil
    case authenticationLocked
    case notValidOtpCode
    case redirectAuth

    var errorMessage: String {
        switch self {
        case .noError:
            return "No data found"
        case .credentialsWrong:
            return "Username or password is incorrect"
        case .notConnectedInternet:
            return "No Internet connection"
        case .serviceResponseFailed:
            return "No service response received"
        case .conflictCredentials:
            return "Conflicting credentials"
        case .emptyOrNil:
            return "Empty or null value"
        case .authenticationLocked:
            return "Authentication locked"
        case .notValidOtpCode:
            return "Invalid OTP code"
        case .redirectAuth:
            return "Redirect requires authentication"
        }
    }
}
