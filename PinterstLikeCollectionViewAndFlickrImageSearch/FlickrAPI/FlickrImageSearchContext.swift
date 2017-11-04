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
}

extension FlickrImageSearchContext{
    /// 端末の通信状態を取得
    ///
    /// - Returns: true: オンライン, false: オフライン
    static func isReachable() -> Bool {
        guard let reachabilityManager = NetworkReachabilityManager() else { return false }
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
        
        return morePhotosExist
    }
    
    var isFetching:Bool{
        /* リクエストを送信して、結果が返ってくるまではtrue
         それ以外はfalse
         
         →TODO: フラグを立てて、リクエストを送信したら変更、結果が帰ってきたら変更
         */
        return state.isFetching
    }
    
    var morePhotosExist:Bool {
        /*
         最新の検索結果を参照して、
         これまでに検索し終わった件数が検索結果総数に達していなければtrue
         
         →TODO: 最新の検索結果を参照して計算
         */
        return state.morePhotosExist
    }
}

extension FlickrImageSearchContext{
    /// keyword -> [UIImage]
    /// In most cases, this method is sufficient!😇
    ///
    /// - Parameters:
    ///   - keyword: related to image
    ///   - completion: handles [UIImage]
    func getImage(of keyword:String,
                  completion:@escaping (Result<[UIImage],ClientError>) -> Void) {
        self.state = State.Fetching()
        flickrAPIManager.getImage(of: keyword){[unowned self] in
            completion($0)
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
        }
    }
}
