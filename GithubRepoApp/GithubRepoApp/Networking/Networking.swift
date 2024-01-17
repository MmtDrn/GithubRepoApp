//
//  Networking.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 17.01.2024.
//

import Foundation
import Alamofire

class Networking: NetworkingProtocol {
    
    static let shared = Networking()
    private init() { }
    
    func request<T: Decodable>(router: EndpointConfiguration,
                               thread: DispatchQoS.QoSClass? = nil,
                               completion: @escaping (T?, NetworkError?) -> Void) {
        switch thread {
        case .background:
            DispatchQueue.global(qos: .background).async {
                self.handleRequest(router: router,
                              completion: completion)
            }
        default:
            self.handleRequest(router: router,
                          completion: completion)
        }
    }
    
    private func handleRequest<T: Decodable>(router: EndpointConfiguration,
                                             completion: @escaping (T?, NetworkError?) -> Void) {
        self.callRequest(router: router,
                    completion: completion)
    }
    
    private func callRequest<T: Decodable>(router: EndpointConfiguration,
                                           completion: @escaping (T?, NetworkError?) -> Void) {
        
        AF.request(router).responseDecodable(of: T.self) { response in
            self.handleResponse(response: response, completion: completion)
        }
    }
    
    private func handleResponse<T: Decodable>(response: DataResponse<T, AFError>,
                                              completion: @escaping (T?, NetworkError?) -> Void) {
        printLog(response: response)
        switch response.result {
        case .success(let data):
            guard let validatedStatusCode = response.response?.statusCode else { return }
            switch validatedStatusCode {
            case 200..<300:
                completion(data, nil)
            case 406:
                completion(nil, .notValidOtpCode)
            case 417:
                completion(nil, .redirectAuth)
            case 423:
                completion(nil, .authenticationLocked)
            default:
                completion(nil, .noError)
            }
        case .failure:
            if !ConnectionManager.isConnectedToNetwork() {
                completion(nil, .notConnectedInternet)
            }
            else {
                completion(nil, .noError)
            }
        }
    }
    
    private func printLog<T: Decodable>(response: AFDataResponse<T>) {
        print("\n\n\n")
        print("🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐")
        debugPrint(response)
        print("🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐")
        print("\n\n\n")
    }
}
