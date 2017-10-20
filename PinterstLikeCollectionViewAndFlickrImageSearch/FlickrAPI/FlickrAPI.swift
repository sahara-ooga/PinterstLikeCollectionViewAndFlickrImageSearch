//
//  FlickrAPI.swift
//  GithubSearchRepository
//
//  Created by yuu ogasawara on 2017/05/26.
//  Copyright © 2017年 stv. All rights reserved.
//

final class FlickrAPI {
    struct SearchPhotos:Request {
        typealias Response = FlickrImageSearchResponse
        
        let text:String
        let page:Int
        let perPage:Int
        
        var method: HTTPMethod{
            return .get
        }
        
        var path: String{
            return ""
        }
        
        var parameters: Any?{
            return ["text": text,"page": String(page),"per_page": String(perPage)]
                .merging(["nojsoncallback":"1",
                          "format":"json",
                          "method":"flickr.photos.search",
                          "api_key":"6f7dace7ed84df51d86c71aefa3100ad"]){ (current, _) in current }
        }
    }
    
//    struct SearchUsers:Request {
//        let text:String
//
//        typealias Response = SearchResponse<User>
//
//        var method: HTTPMethod{
//            return .get
//        }
//
//        var path: String{
//            return "/search/users"
//        }
//
//        var parameters: Any?{
//            return ["q":text]
//        }
//
//    }
}
