//
//  FlickrImageSearchContext.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by Yuu Ogasa on 2017/11/02.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

final class FlickrImageSearchContext{
    /// 端末の通信状態を取得
    ///
    /// - Returns: true: オンライン, false: オフライン
    static func isReachable() -> Bool {
        guard let reachabilityManager = NetworkReachabilityManager() else { return false }
            reachabilityManager.startListening()
            return reachabilityManager.isReachable
    }
}
