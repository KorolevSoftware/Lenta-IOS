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
    
    func getDataSync(url:URL) -> Data? {
        let semaphore = DispatchSemaphore(value: 0)
        
        // Global value for web
        let session = URLSession.shared
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        // Main ui sync
        
        var result:Data? = nil
        // if cache have data get him, else load/cache and get him
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data {
                result = data
                semaphore.signal()
            }
            else{
                session.dataTask(with: url) {(data, responce, error) in
                    guard let data = data, let responce = responce  else {
                        print("NetworkService error \(String(describing: error))")
                        return
                    }
                    let cacheData = CachedURLResponse(response: responce, data: data)
                    cache.storeCachedResponse(cacheData, for: request)
                    result = data
                    semaphore.signal()
                    }.resume()
            }
        }
        semaphore.wait()
        
        return result
    }
    func getDataAsyncMain(url:URL, complition: @escaping (Data) -> ())
    {
        let mainAsync:(Data)->Void = { data in
            DispatchQueue.main.async {
                complition(data)
            }
        }
        
        self.getDataAsync(url: url) { data in
            mainAsync(data)
        }
        
    }
    func getDataAsync(url:URL, complition: @escaping (Data) -> ()) {
        
        // Global value for web
        let session = URLSession.shared
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        // Main ui sync
 
        
        // if cache have data get him, else load/cache and get him
        DispatchQueue.global(qos: .userInitiated).async {
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
