//
//  States.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by yogasawara@stv on 2017/11/04.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//
struct State{
    struct StandBy: FlickrAPIAccessState {
        var latestSearchResponse: FlickrImageSearchResponse? = nil
        
        let isWaitingForResponse: Bool = false
        
        var moreImagesExist: RelatedImagesExist = .unknown
        
        let isFetching = false
    }

    struct Fetching:FlickrAPIAccessState{
        var latestSearchResponse: FlickrImageSearchResponse?
        let moreImagesExist: RelatedImagesExist = .unknown
        let isFetching = true
    }

    struct PartialllyFetched: FlickrAPIAccessState {        
        var latestSearchResponse: FlickrImageSearchResponse?
        
        let moreImagesExist: RelatedImagesExist = .exist
        
        let isFetching = false
        
    }

    struct AllFetched: FlickrAPIAccessState {
        var latestSearchResponse: FlickrImageSearchResponse?
        let moreImagesExist: RelatedImagesExist = .notExist
        let isFetching = false
    }
    
    struct Errored: FlickrAPIAccessState {
        var latestSearchResponse: FlickrImageSearchResponse? = nil
        let isFetching: Bool = false
        let error:Error
        let moreImagesExist: RelatedImagesExist = .unknown
    }
}
