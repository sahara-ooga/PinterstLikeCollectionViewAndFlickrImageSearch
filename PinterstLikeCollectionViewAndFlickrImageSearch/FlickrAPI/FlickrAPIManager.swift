//
//  FlickrAPIManager.swift
//  Frontend of Flickr API.
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by yogasawara@stv on 2017/10/21.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import UIKit

class FlickrAPIManager {
// MARK: - property
    private let session:URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
}

// MARK: - Image search and Fetch
extension FlickrAPIManager{
    
    /// Search photos related to keyWord via FlickrAPI
    ///
    /// - Parameters:
    ///   - keyWord: search keyword
    ///   - page: appoint position of search results
    ///   - perPage: designates number of search results
    ///   - completionHandler: specify management when reseived search results.
    func search(_ keyWord:String,
                to page:Int = 1,
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
    
    /// acquire images based on flickr image search response.
    ///
    /// - Parameters:
    ///   - searchResponse: Flickr image search response
    ///   - completionHandler: manage images, which flickr image search shows
    func fetch(for searchResponse:FlickrImageSearchResponse,
               completionHandler:@escaping ([UIImage]?)->Void) {
        let photos = searchResponse.photos.photo
        
        if photos.isEmpty {
            completionHandler(nil)
        }
        
        var images = [UIImage]()
        
        // APIクライアントの生成
        let client = FlickrClient()
        
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "queue", attributes: .concurrent)

        for photo in photos{
            dispatchGroup.enter()
            dispatchQueue.async(group: dispatchGroup){
               // [weak self] in
                let baseURL = URL(string:photo.imageBaseURL)!
                let path = photo.imagePath
                let request = FlickrAPI.FetchPhoto(baseURL: baseURL,
                                                   path:path,
                                                   parameters: nil)
                
                // リクエストの送信
                client.send(request: request){

                    result in
                        switch result {
                        case let .success(response):
                            if let image = response.image {
                                images.append(image)
                            }
                        case let .failure(error):
                            //エラー詳細を出力
                            print(error)
                        }
                    
                        //when finish treating result, leave the dispatch group.
                        dispatchGroup.leave()
                    }
            }
            
        }
        
        //have completionHandler wait for fetching images
        dispatchGroup.notify(queue: .main) {
            completionHandler(images)
        }
    }
    
    func fetch(to url:URL,completion:@escaping (UIImage?)->Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        let task = session.dataTask(with: urlRequest,
                                    completionHandler: {data,response,error in
                                        
                                        switch (data,response,error){
//                                        case (_, _, let error?):
//                                            //completion(Result(error: .connectionError(error)))
//                                            completion(nil)
                                        case (let data?, _?, _):
                                            guard let image = UIImage(data: data) else{
                                                completion(nil)
                                                return
                                            }
                                            completion(image)
                                        default:
                                            fatalError("invalid response combination \(String(describing: data)), \(String(describing: response)), \(String(describing: error)).)")
                                        }
        })
        
        task.resume()
    }
}
