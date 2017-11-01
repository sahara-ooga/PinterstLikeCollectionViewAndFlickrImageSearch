//
//  FlickrAPIAccessState.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by Yuu Ogasa on 2017/11/01.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

struct FlickrAPIAccessState {
    var latestSearchResponse:FlickrImageSearchResponse?
    
    var morePhotosExist:Bool {
        /*
         最新の検索結果を参照して、
         これまでに検索し終わった件数が検索結果総数に達していなければtrue
         
         →TODO: 最新の検索結果を参照して計算
         */
        
        guard let response = latestSearchResponse else {
            return false
        }
        
        let currentPage = response.photos.page
        let totalPageNum = response.photos.pages
        return currentPage < totalPageNum
    }
    
    var isWaitingForResponse:Bool = false
//    var isWaitingForResponse:Bool{
//        /* リクエストを送信して、結果が返ってくるまではtrue
//         それ以外はfalse
//
//         →TODO: フラグを立てて、リクエストを送信したら変更、結果が帰ってきたら変更
//         */
//        return false
//    }
}
