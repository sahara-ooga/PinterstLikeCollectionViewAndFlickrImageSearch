//
//  FlickrImageSearchContextError.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by yogasawara@stv on 2017/11/05.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

enum FlickrImageSearchContextError:Error {
    case alreadyFetching
    case noMorePage
    case noResponse
    case noPreviousPage
}
