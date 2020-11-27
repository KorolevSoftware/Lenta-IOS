//
//  NetworkService.swift
//  Lenta
//
//  Created by Dmitry Korolev on 23.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import Foundation

enum NetworkResponse<T> {
    case success(T,_ isCeche: Bool)
    case failure( NetworkError)
}

enum NetworkError: CustomStringConvertible {
    case unknown
    case noNetworkConnect
    case noDataOrResponse
    case decodeDataError
    case urlError
    
    var description : String {
        switch self {
        case .unknown: return " Network Error unknown"
        case .noNetworkConnect: return "NetworkError no internet connection, check internet"
        case .noDataOrResponse: return "NetworkError no data or response"
        case .decodeDataError: return "NetworkError decode data Error(json)"
        case .urlError: return "Url Error"
        }
    }
}

class NetworkService {
    
    private init() {}
    
    static let shared = NetworkService()
    
    func getFromCache(request: URLRequest) -> Data? {
        let cache = URLCache.shared
        return cache.cachedResponse(for: request)?.data
    }
    
    func saveFromCache(response:URLResponse, request: URLRequest, data: Data) {
        let cache = URLCache.shared
        let cacheData = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cacheData, for: request)
    }
    
    func getDataAsync(url:URL, complition: @escaping (NetworkResponse<Data>) -> Void) {
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        session.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response  else {
                if let error = error as? URLError, error.code == URLError.Code.notConnectedToInternet {
                    if let cacheData = self.getFromCache(request: request) {
                        complition(.success(cacheData, true))
                    }
                    else {
                        complition(.failure(.noNetworkConnect))
                    }
                }
                return complition(.failure(.noDataOrResponse))
            }
            self.saveFromCache(response:response, request: request, data: data)
            complition(.success(data, false))
            }.resume()
        }
    }

