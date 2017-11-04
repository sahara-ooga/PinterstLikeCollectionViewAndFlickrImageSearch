//
//  FlickrImageSearchResult.swift
//  ios-pinterest-taste-ui
//
//  Created by yogasawara@stv on 2017/10/19.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import Foundation

struct FlickrImageSearchResponse: Codable {
    let photos:Photos
    let stat: String
}

extension FlickrImageSearchResponse{
    var moreImagesExist: RelatedImagesExist{
        let total = Int(photos.total)!
        //let page = photos.page
        let pages = photos.pages
        let perpage = photos.perpage
        let numOfCurrentPhotos = photos.photoInfos.count
        
        //If total <= perpage, no more search is needed.
        if total <= perpage{
            return .notExist
        }
        
        //in the below, total > perpage
        //So, at least searching two times is needed.
        if numOfCurrentPhotos < perpage {
            return .notExist
        }
        
        //in the below, numOfcurrentPhotos = perpage
        if total == perpage * pages{
            return .notExist
        }else{
            return .exist
        }
        
        //return .unknown
    }
}
