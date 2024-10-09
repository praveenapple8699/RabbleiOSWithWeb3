//
//  NetworkRequest.swift
//  RabbleiOS
//
//  Created by PraveenKumar on 08/10/24.
//

import Foundation


struct NetworkRequest {
    
    let networkMethod: NetworkMethod
    let baseURL: URL
    let queryItems: [URLQueryItem]
    let path: String
    init(networkMethod: NetworkMethod,
         baseURL:URL = APIEndpoints.baseURL,
         queryItems: [URLQueryItem] = [],
         path: String) {
        self.baseURL = baseURL
        self.networkMethod = networkMethod
        self.queryItems = queryItems
        self.path = path
    }
    
    
}

public enum NetworkMethod: String {
    case GET = "GET"
    case PUT = "PUT"
    case POST = "POST"
    case DELETE = "DELETE"
}

struct NetworkError: Error {
    var message: String?
}
