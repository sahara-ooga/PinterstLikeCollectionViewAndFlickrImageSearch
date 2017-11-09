//
//  FlickrImageSearchContext.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by Yuu Ogasa on 2017/11/02.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//
import UIKit

final class FlickrImageSearchContext{
    private var state:FlickrAPIAccessState = State.StandBy()
    let flickrAPIManager = FlickrAPIManager()
    var requestedKeyword:String?
    var currentPage = 1
}

extension FlickrImageSearchContext{
    /// 端末の通信状態を取得
    ///
    /// - Returns: true: オンライン, false: オフライン
    var isReachable:Bool {
        guard let reachabilityManager = NetworkReachabilityManager()
            else { return false }
            reachabilityManager.startListening()
            return reachabilityManager.isReachable
    }
}

// MARK: - Infomation to judge wheather Additional Search is needed
extension FlickrImageSearchContext{
    var shouldSearchMorePhotos:Bool {
        if self.isFetching {
            return false
        }
        
        switch state.moreImagesExist {
        case .exist:
            return true
        default:
            return false
        }
    }
    
    var isFetching:Bool{
        /* リクエストを送信して、結果が返ってくるまではtrue
         それ以外はfalse
         
         →TODO: フラグを立てて、リクエストを送信したら変更、結果が帰ってきたら変更
         */
        return state.isFetching
    }
    
    var morePageDoesExist:Bool{
        return state.morePhotosExist
    }
    
}

extension FlickrImageSearchContext{
    /// keyword -> [UIImage]
    ///
    /// - Parameters:
    ///   - keyword: related to image
    ///   - completion: handles [UIImage]
    func getImage(of keyword:String,
                  completion:@escaping (Result<[UIImage],ClientError>) -> Void) {
        if !isReachable {
            completion(Result(error: .connectionError(.isNotReachable)))
        }
        
        if self.isFetching {
            completion(Result(error: .flickrImageSearchContextError(.alreadyFetching)))
            return
        }
        
        #if false
        //新規検索時に、前の状態で弾いてしまう
            if self.state.moreImagesExist == .notExist {
            completion(Result(error: .flickrImageSearchContextError(.noMorePage)))
            return
        }
        
        #endif
        
        self.state = State.Fetching()
        self.requestedKeyword = keyword
        
        flickrAPIManager.getImage(of: keyword){[unowned self] in
            
            if let response = self.flickrAPIManager.imageSearchResponse{
                switch response.moreImagesExist{
                case .exist:
                    self.state = State.PartialllyFetched()
                case .notExist:
                    self.state = State.AllFetched()
                case .unknown:
                    self.state = State.AllFetched()
                }
                
                self.update(to: response)

            }
            
            completion($0)
        }
    }
    
    func getMoreImage(completion:@escaping (Result<[UIImage],ClientError>) -> Void) {
        if self.isFetching {
            completion(Result(error: .flickrImageSearchContextError(.alreadyFetching)))
            return
        }
        
        if self.state.moreImagesExist == .notExist {
            completion(Result(error: .flickrImageSearchContextError(.noMorePage)))
            return
        }
        
        self.state = State.Fetching()
        
        guard let previousPage = self.flickrAPIManager.imageSearchResponse?.photos.page else {
            completion(Result(error: .flickrImageSearchContextError(.noPreviousPage)))
            return
        }
        
        let requestPage = previousPage + 1
        flickrAPIManager.getImage(of: self.requestedKeyword!,to:requestPage){[unowned self] in
            
            if let response = self.flickrAPIManager.imageSearchResponse{
                switch response.moreImagesExist{
                case .exist:
                    self.state = State.PartialllyFetched()
                case .notExist:
                    self.state = State.AllFetched()
                case .unknown:
                    self.state = State.AllFetched()
                }
                
                self.update(to: response)
            }
            
            completion($0)
        }
    }
}

extension FlickrImageSearchContext{
    func cancelSearch(){
        flickrAPIManager.cancelSearch()
        self.state = State.StandBy()
    }
}

extension FlickrImageSearchContext:FlickrAPIAccessStateManagable{
    func update(to latestSearchResponse: FlickrImageSearchResponse) {
        self.state.latestSearchResponse = latestSearchResponse
        self.currentPage = latestSearchResponse.photos.page
    }
    
}
