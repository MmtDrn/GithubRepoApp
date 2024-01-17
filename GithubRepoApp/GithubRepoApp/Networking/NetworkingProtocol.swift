//
//  NetworkingProtocol.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 17.01.2024.
//

import Foundation

protocol NetworkingProtocol {
    func request<T: Decodable>(router: EndpointConfiguration,
                               thread: DispatchQoS.QoSClass?,
                               completion: @escaping (T?, NetworkError?) -> Void)
}

extension NetworkingProtocol {
    func request<T: Decodable>(router: EndpointConfiguration,
                               thread: DispatchQoS.QoSClass? = nil,
                               completion: @escaping (T?, NetworkError?) -> Void) {
        
        request(router: router,
                thread: thread,
                completion: completion)
    }
}
