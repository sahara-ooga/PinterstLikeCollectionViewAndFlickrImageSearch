//
//  FlickrAPIManager.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by yogasawara@stv on 2017/10/21.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import Foundation

class FlickrAPIManager {
// MARK: - property
    
}

// MARK: - Image search and Fetch
extension FlickrAPIManager{
    func search(_ keyWord:String,to page:Int = 1,
                perPage:Int = CommonDefines.perPage,
                completionHandler:@escaping (Result<FlickrImageSearchResponse,ClientError>) -> Void) {
        // APIクライアントの生成
        let client = FlickrClient()
        
        //リクエストの発行
        let request = FlickrAPI.SearchPhotos(text: keyWord,
                                             page: page,
                                             perPage: perPage)
        
        // リクエストの送信
        client.send(request: request){
            result in
            completionHandler(result)
        }
    }
    
    
}
