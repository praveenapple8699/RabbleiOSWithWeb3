//
//  NetworkService.swift
//  RabbleiOS
//
//  Created by PraveenKumar on 08/10/24.
//

import Foundation
import Network

protocol NetworkServiceDelegate: AnyObject {
    var isInternetAvailable: Bool { get }
    func request(networkRequest: NetworkRequest,
                 completion: @escaping (Data?, String?) -> ())
}

final class NetworkService: NetworkServiceDelegate {
    var isInternetAvailable: Bool = false
    private let networkMonitor = NWPathMonitor()
    private var request: NetworkRequest?
    private let networkMonitoringQueue = DispatchQueue(label: "Network_Monitor")
    init() {
        monitorNetwork()
    }
    
    private func monitorNetwork() {
        networkMonitor.pathUpdateHandler = {[weak self] path in
            self?.isInternetAvailable = path.status == NWPath.Status.satisfied
        }
        networkMonitor.start(queue: networkMonitoringQueue)
    }
    
    func request(networkRequest: NetworkRequest,
                 completion: @escaping (Data?, String?) -> ()) {
        
        guard isInternetAvailable else {
            completion(nil,StringConstants.NO_INTERNET)
            return
        }
        
        var urlComponents = URLComponents()
        let baseURL = networkRequest.baseURL
        urlComponents.scheme = baseURL.scheme
        urlComponents.host = baseURL.host
        urlComponents.path = baseURL.path
        if !networkRequest.queryItems.isEmpty {
            urlComponents.queryItems = networkRequest.queryItems
        }
        
        guard let url = urlComponents.url?.appendingPathComponent(networkRequest.path) else {
            completion(nil,StringConstants.INVALID_URL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = networkRequest.networkMethod.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(nil,error?.localizedDescription)
            } else if data == nil {
                completion(nil,StringConstants.RESPONSE_DATA_NIL)
            } else {
                completion(data,nil)
            }
        }
        
        dataTask.resume()
        
    }
    
}
