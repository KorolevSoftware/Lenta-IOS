//
//  NetworkFlickr.swift
//  Lenta
//
//  Created by Dmitry Korolev on 20.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import Foundation


class NetworkFlickr
{
    public func getInterestingnes(complit: @escaping ([FlickrPictureID]) -> ())
    {
        let base = "https://api.flickr.com/services/rest/?method=flickr.interestingness.getList"
        let key = "&api_key=f52542e77c35e91f4a50303ed505ac14"
        let format = "&format=json&nojsoncallback=1"
        let sort = "&sort=relevance"
        let searchUrl = base + key + sort + format
        
        let url = URL(string: searchUrl)!
        
        
        NetworkService.shared.getDataAsync(url: url) { (data) in
            do {
                let picPage = try JSONDecoder().decode(FlickrPicturePages.self, from: data)
                complit(picPage.photos.photo!)
            }
            catch {
                print("Error decode data \(String(describing: error))")
            }
        }
    }
    
    
    
    func pictureInfo(flickrPictureID:FlickrPictureID) -> FlickrPicture? {
        let base = "https://api.flickr.com/services/rest/?method=flickr.photos.getInfo"
        let key = "&api_key=f52542e77c35e91f4a50303ed505ac14"
        let format = "&format=json&nojsoncallback=1"
        let extras = "&photo_id=\(flickrPictureID.id)"
        let searchUrl = base + key + format + extras
        
        let url = URL(string: searchUrl)!
        
        guard let data:Data = NetworkService.shared.getDataSync(url: url) else { return nil }
        
//        NetworkService.shared.
        do {
            let pictureInfo = try JSONDecoder().decode(FlickrPictureContainer.self, from: data).photo
            
            return FlickrPicture(pictureInfo: pictureInfo)
        }
        catch {
            print("Error decode data \(String(describing: error))")
        }
        
        return nil
    }
    
    
    func loadQuadPicture(picture:FlickrPicture, complit: @escaping (Data) -> ())
    {
            let base = "https://api.flickr.com/services/rest/?method=flickr.photos.getSizes"
            let key = "&api_key=f52542e77c35e91f4a50303ed505ac14"
            let format = "&format=json&nojsoncallback=1"
            let extras = "&photo_id=\(picture.id)"
            let searchUrl = base + key + format + extras
            
            let url = URL(string: searchUrl)!
            
            guard let data:Data = NetworkService.shared.getDataSync(url: url) else { return }
            
            var quadURL:URL?
            
            do {
                let picPage:FlickrImageSizes = try JSONDecoder().decode(FlickrImageSizes.self, from: data)
                quadURL = picPage.sizes.size[1].url
            }
            catch {
                print("Error decode data \(String(describing: error))")
                return
            }
//            NetworkService.shared.getDataAsyncMain(url: quadURL!, complition: complit)
        
        let session = URLSession.shared
        let cache = URLCache.shared
        let request = URLRequest(url: quadURL!)
        
        // Main ui sync
        
        
        // if cache have data get him, else load/cache and get him
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data {
                DispatchQueue.main.async {
                    complit(data)
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
                        complit(data)
                    }
                    }.resume()
            }
        }
        

    }
    
    
    func loadOrigPicture(picture:FlickrPicture, complit: @escaping (Data) -> ())
    {
            
            let base = "https://api.flickr.com/services/rest/?method=flickr.photos.getSizes"
            let key = "&api_key=f52542e77c35e91f4a50303ed505ac14"
            let format = "&format=json&nojsoncallback=1"
            let extras = "&photo_id=\(picture.id)"
            let searchUrl = base + key + format + extras
            
            let url = URL(string: searchUrl)!
            
            guard let data:Data = NetworkService.shared.getDataSync(url: url) else { return }
            
            var quadURL:URL?
            
            do {
                let picPage:FlickrImageSizes = try JSONDecoder().decode(FlickrImageSizes.self, from: data)
                quadURL = picPage.sizes.size[8].url
            }
            catch {
                print("Error decode data \(String(describing: error))")
                return
            }
            NetworkService.shared.getDataAsyncMain(url: quadURL!, complition: complit)
    }
    
}
