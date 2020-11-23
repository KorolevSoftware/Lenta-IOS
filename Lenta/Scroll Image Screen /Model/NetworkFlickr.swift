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
    
    public func getData(closure:@escaping ([Picture])-> Void )
    {
        let base = "https://api.flickr.com/services/rest/?method=flickr.interestingness.getList"
        let key = "&api_key=f52542e77c35e91f4a50303ed505ac14"
        let format = "&format=json&nojsoncallback=1"
        let sort = "&sort=relevance"
        let extras = "&extras=url_q"
        
        let searchUrl = base + key + sort + format + extras;
        
        let url = URL(string: searchUrl)!
        print(searchUrl)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let picPage = try JSONDecoder().decode(PicturePages.self, from: data)
                    
                    if var photos:[Picture] = picPage.photos.photo {
                        
                        for index in photos.indices {
                            
                            URLSession.shared.dataTask(with:photos[index].url_q) { (imageData, _, _) in
                                if let imageData = imageData {
                                    photos[index].image = imageData
                                }
                                
                                DispatchQueue.main.async {
                                    closure(photos)
                                }
                                
                            }.resume()
                        }
                    
                    DispatchQueue.main.async {
                        closure(photos)
                    }
                }
                    
                } catch {
                    print(error)
                }
            }
   
        }.resume()
    }
}
