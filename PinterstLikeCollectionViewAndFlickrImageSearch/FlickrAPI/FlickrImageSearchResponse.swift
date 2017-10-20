//
//  FlickrImageSearchResult.swift
//  ios-pinterest-taste-ui
//
//  Created by yogasawara@stv on 2017/10/19.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import Foundation

struct FlickrImageSearchResponse: Codable {
    struct Photos: Codable {
        struct Photo: Codable {
            //{"id":"37740742912","owner":"102701238@N03","secret":"7ec913dfea","server":"4462","farm":5,"title":"New photo added to \"All Photos\"","ispublic":1,"isfriend":0,"isfamily":0},
            let id: String
            let owner: String
            let secret: String
            let server: String
            let farm: Int
            let title: String
            let ispublic: Int
            let isfriend: Int
            let isfamily: Int
            
            //URLを組み立てて返す計算型プロパティ
            /*
             format: "https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg"
             */
            
            var imageURL:String{
                return "https://farm" + String(farm) + ".staticflickr.com/" + server + "/" + id + "_" + secret + ".jpg"
            }
        }
        
        let page: Int
        let pages: Int
        let perpage: Int
        let total: String
        let photo:[Photo]
    }
    
    let photos:Photos
    let stat: String
}
