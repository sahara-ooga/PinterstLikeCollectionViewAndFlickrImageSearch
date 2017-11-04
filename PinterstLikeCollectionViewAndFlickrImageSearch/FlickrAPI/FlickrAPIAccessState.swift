//
//  FlickrAPIAccessState.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by Yuu Ogasa on 2017/11/01.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

protocol FlickrAPIAccessState {
    var latestSearchResponse:FlickrImageSearchResponse? {get set}
    var isFetching:Bool { get }
    var moreImagesExist:RelatedImagesExist { get }
}

extension FlickrAPIAccessState{
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
    
    //今何ページ目の情報を持っているのか？
    var page:Int?{
        guard let response = latestSearchResponse else {
            return nil
        }
        return response.photos.page
    }
    
    var totalPages:Int?{
        guard let response = latestSearchResponse else {
            return nil
        }
        return response.photos.pages
    }
    
    var numOfPhotos:Int?{
        guard let response = latestSearchResponse else {
            return nil
        }
        return Int(response.photos.total)
    }
    
    var perPages:Int?{
        guard let response = latestSearchResponse else {
            return nil
        }
        return response.photos.perpage
    }
    
}

enum RelatedImagesExist{
    case exist
    case notExist
    case unknown
}
