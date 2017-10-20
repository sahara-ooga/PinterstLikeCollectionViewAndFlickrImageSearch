//
//  FlickrAPI.swift
//  GithubSearchRepository
//
//  Created by yuu ogasawara on 2017/05/26.
//  Copyright © 2017年 stv. All rights reserved.
//
import UIKit

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
    
    struct FetchPhoto:Request {
        typealias Response = FlickrImageFetchResponse
        var baseURL: URL    //image url which is formed based on image search api response
        
        var method: HTTPMethod{
            return .get
        }
        
        var path: String{
            return ""
        }
        
        var parameters: Any? = nil
        
        func response(from data:Data,
                      urlResponse:URLResponse) throws -> Response {
            
            if case (200..<300)? = (urlResponse as? HTTPURLResponse)?.statusCode {
//                //JSONからモデルをインスタンス化
//                return try JSONDecoder().decode(FlickrImageSearchResponse.self,
//                                                from: data) as! Self.Response
                return Response(image: UIImage(data: data))
            } else {
                //JSONからAPIエラーをインスタンス化
                throw try APIError(from: data as! Decoder)
            }
            
        }
    }
}
