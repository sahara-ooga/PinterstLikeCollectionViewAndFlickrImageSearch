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
<<<<<<< HEAD
    let flickrAPIManager = FlickrAPIManager()
    var requestedKeyword:String?
=======
    private let flickrAPIManager = FlickrAPIManager()
    private var searchedKeyword:String?
>>>>>>> state
}

extension FlickrImageSearchContext{
    /// 端末の通信状態を取得
    ///
    /// - Returns: true: オンライン, false: オフライン
    static func isReachable() -> Bool {
        guard let reachabilityManager = NetworkReachabilityManager()
            else { return false }
            reachabilityManager.startListening()
            return reachabilityManager.isReachable
    }
}

// MARK: - Infomation to judge wheather Additional Search is needed
extension FlickrImageSearchContext{
    func shouldShearchMorePhotos(_ keyword:String) -> Bool {
        if keyword != requestedKeyword{
            return true
        }
        
        if isFetching {
            return false
        }
        
        guard keyword == requestedKeyword,!isFetching else {
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
    
}

extension FlickrImageSearchContext{
    /// keyword -> [UIImage]
<<<<<<< HEAD
    ///
=======
>>>>>>> state
    ///
    /// - Parameters:
    ///   - keyword: related to image
    ///   - completion: handles [UIImage]
    func getImage(of keyword:String,
                  perPage:Int = CommonDefines.perPage,
                  completion:@escaping (Result<[UIImage],ClientError>) -> Void) {
<<<<<<< HEAD
        if isFetching  {
            let error = ClientError.flickrImageSearchContextError(.alreadyFetching)
            completion(Result(error: error))
        }
                
        // その検索キーワードですでに検索しているかどうか調べる
        // 前回のキーワードが無い、または引数と前回のキーワードが異なる時
        // １ページ目をリクエスト;
        guard let rKeyword = requestedKeyword,
            rKeyword == keyword else {
            //前回キーワードが無いまたはキーワードが新しいケース。
            //新しいキーワードで１ページ目を検索する
            self.state = State.Fetching()
            requestedKeyword = keyword
            let requestPage = 1
            flickrAPIManager.getImage(of: keyword,
                                      to: requestPage,
            perPage: perPage){[unowned self] result in
                switch result{
                case .success(let response):
                    if let imageSearchResponse = self.flickrAPIManager.imageSearchResponse{
                        switch imageSearchResponse.moreImagesExist{
                        case .exist:
                            self.state = State.PartialllyFetched()
                        case .notExist:
                            self.state = State.AllFetched()
                        case .unknown:
                            self.state = State.AllFetched()
                        }
                    }
                    completion(Result(value: response))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            return
        }
        
        // ２回目以降(前回とキーワードが同じ)なら、
        // まず次のページが有るかどうかを調べる
        if morePhotosExist == false{
            let error = ClientError.flickrImageSearchContextError(.noMorePage)
            self.state = State.Errored(latestSearchResponse: nil, error: error)
            completion(Result(error: error))
            return
        }
        
        // 次のページがある場合、既存のレスポンスのページをインクリメントしてリクエストする
        guard let requestedPage = self.flickrAPIManager.imageSearchResponse?.photos.page
            else{
            let error = ClientError.flickrImageSearchContextError(.noResponse)
            self.state = State.Errored(latestSearchResponse: nil, error: error)
            completion(Result(error: error))
            return
        }
        
        let requestPage = requestedPage + 1
        flickrAPIManager.getImage(of: keyword,
                                  to: requestPage,
                                  perPage: perPage)
                                   {result in
                                    switch result{
                                    case .success(let response):
                                        if let imageSearchResponse = self.flickrAPIManager.imageSearchResponse{
                                            switch imageSearchResponse.moreImagesExist{
                                            case .exist:
                                                self.state = State.PartialllyFetched()
                                            case .notExist:
                                                self.state = State.AllFetched()
                                            case .unknown:
                                                self.state = State.AllFetched()
                                            }
                                        }
                                        completion(Result(value: response))

                                    case .failure(let error):
                                        completion(.failure(error))
                                    }
=======
        if self.isFetching {
            completion(Result(error: .searchContextError(.isLoading)))
            return
        }
        
        if self.state.moreImagesExist == .notExist {
            completion(Result(error: .searchContextError(.noMorePhoto)))
            return
        }
        
        self.state = State.Fetching()
        self.searchedKeyword = keyword
        
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
            }
            
            completion($0)
        }
    }
    
    func getMoreImage(completion:@escaping (Result<[UIImage],ClientError>) -> Void) {
        if self.isFetching {
            completion(Result(error: .searchContextError(.isLoading)))
            return
        }
        
        if self.state.moreImagesExist == .notExist {
            completion(Result(error: .searchContextError(.noMorePhoto)))
            return
        }
        
        self.state = State.Fetching()

        flickrAPIManager.getImage(of: self.searchedKeyword!){[unowned self] in
            
            if let response = self.flickrAPIManager.imageSearchResponse{
                switch response.moreImagesExist{
                case .exist:
                    self.state = State.PartialllyFetched()
                case .notExist:
                    self.state = State.AllFetched()
                case .unknown:
                    self.state = State.AllFetched()
                }
            }
            
            completion($0)
>>>>>>> state
        }
    }
    
}
