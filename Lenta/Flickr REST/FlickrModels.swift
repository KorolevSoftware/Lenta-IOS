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
        let photo:[FlickrPicture]?
    }
}

struct Description: Decodable  {
    let content:String
    
    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
}

struct FlickrPicture:ProtoModel, Decodable {
    let id:String
    var title: String
    var description: String {
        get{ return descriptionRaw.content }
    }
    let descriptionRaw: Description
    var authName: String
    var viewCount: String
    let quadPicture:URL
    let originPicture:URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case quadPicture = "url_q"
        case originPicture = "url_c"
        case authName = "ownername"
        case viewCount = "views"
        case descriptionRaw = "description"
    }
}

/// Flickr Picture Info and all Size

//struct FlickrPictureContainer:Decodable
//{
//    let photo:FlickrPhotoInfo
//}
//struct FlickrPhotoInfo: Decodable {
//    let id:String
//    let title:Title
//    let views:String
//    let dates:FlDate
//    let owner:Owner
//    let description:Description
//
//    struct Owner: Decodable {
//        let realname:String
//    }
//
//    struct Title: Decodable  {
//        let _content:String
//    }
//
//    struct Description: Decodable  {
//        let _content:String
//    }
//    
//    struct FlDate: Decodable  {
//        let posted:String
//    }
//}
//
//struct FlickrImageSizes: Decodable {
//    let sizes:SizesInfo
//
//    struct SizesInfo: Decodable {
//        let size:[Size]
//    }
//    struct Size: Decodable {
//        let label:String
//        let url:URL
//    }
//
//}
