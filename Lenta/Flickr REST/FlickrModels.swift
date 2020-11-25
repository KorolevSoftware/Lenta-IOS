//
//  FlickrModels.swift
//  Lenta
//
//  Created by Dmitry Korolev on 24.11.2020.
//  Copyright © 2020 Dmitry Korolev. All rights reserved.
//

import Foundation

struct FlickrPicturePages: Decodable {
    let photos:FlickrPicturePage

    struct FlickrPicturePage: Decodable {
        let page:Int
        let pages:Int
        let perpage:Int
        let photo:[FlickrPictureID]?
    }
}

struct FlickrPictureID: Decodable {
    let id:String
    let title:String
    let description:Description
    let ownername:String
    let views:String
    let url_q:URL
    let url_c:URL
    
    struct Description: Decodable  {
        let _content:String
    }
}

struct FlickrPicture:ProtoModel {
    let id:String
    var title: String
    var description: String
    var authName: String
    var viewCount: Int
    let url_q:URL
    let url_c:URL
    
    init(pictureID:FlickrPictureID) {
        self.id = pictureID.id
        self.title = pictureID.title
        self.description = pictureID.description._content.isEmpty ?
            pictureID.title:
            pictureID.description._content
            
        
        self.authName = pictureID.ownername
        self.viewCount = Int(pictureID.views) ?? 0
        self.url_q = pictureID.url_q
        self.url_c = pictureID.url_c
    }
    
//    init(pictureInfo:FlickrPhotoInfo) {
//        self.id = pictureInfo.id
//        self.title = pictureInfo.title._content
//        self.description = pictureInfo.description._content.isEmpty ?
//            pictureInfo.description._content:
//        pictureInfo.title._content
//
//        self.authName = pictureInfo.owner.realname
//        self.viewCount = Int(pictureInfo.views) ?? 0
//    }
    
}


struct FlickrPictureContainer:Decodable
{
    let photo:FlickrPhotoInfo
}
struct FlickrPhotoInfo: Decodable {
    let id:String
    let title:Title
    let views:String
    let dates:FlDate	
    let owner:Owner
    let description:Description
    
    struct Owner: Decodable {
        let realname:String
    }
    
    struct Title: Decodable  {
        let _content:String
    }
    
    struct Description: Decodable  {
        let _content:String
    }
    
    struct FlDate: Decodable  {
        let posted:String
    }
}

struct FlickrImageSizes: Decodable {
    let sizes:SizesInfo
    
    struct SizesInfo: Decodable {
        let size:[Size]
    }
    struct Size: Decodable {
        let label:String
        let url:URL
    }
    
}
