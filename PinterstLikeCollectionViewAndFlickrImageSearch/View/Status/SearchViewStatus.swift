//
//  SearchView.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by Yuu Ogasa on 2017/11/06.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

enum SearchViewStatus {
    case none
    case loading
    case noData
    case normal(FlickrImageSearchResponse)
    case offline
    case error
}
