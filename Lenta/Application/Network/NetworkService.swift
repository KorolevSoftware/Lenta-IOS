//
//  NetworkService.swift
//  Lenta
//
//  Created by Dmitry Korolev on 23.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import Foundation

class NetworkService {
    
    private init(){}
    
    static let shared = NetworkService()
  
    func getDataAsyncMain(url:URL, complition: @escaping (Data) -> ())
    {
        // Global value for web
        let session = URLSession.shared
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        // Main ui sync
        
        
        // if cache have data get him, else load/cache and get him
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data {
                DispatchQueue.main.async {
                    complition(data)
                }
            }
            else{
                session.dataTask(with: url) {(data, responce, error) in
                    guard let data = data, let responce = responce  else {
                        print("NetworkService error \(String(describing: error))")
                        return
                    }
                    let cacheData = CachedURLResponse(response: responce, data: data)
                    cache.storeCachedResponse(cacheData, for: request)
                    DispatchQueue.main.async {
                        complition(data)
                    }
                    }.resume()
            }
        }
        
    }
    func getDataAsync(url:URL, complition: @escaping (Data) -> ()) {
        
        // Global value for web
        let session = URLSession.shared
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        // Main ui sync
 
        
        // if cache have data get him, else load/cache and get him
        DispatchQueue.global(qos: .default).async {
            if let data = cache.cachedResponse(for: request)?.data {
                complition(data)
            }
            else{
                session.dataTask(with: url) {(data, responce, error) in
                    guard let data = data, let responce = responce  else {
                        print("NetworkService error \(String(describing: error))")
                        return
                    }
                    let cacheData = CachedURLResponse(response: responce, data: data)
                    cache.storeCachedResponse(cacheData, for: request)
                    complition(data)
                }.resume()
            }
        }
    }
}
