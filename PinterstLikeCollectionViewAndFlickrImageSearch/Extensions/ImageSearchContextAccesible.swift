//
//  ImageSearchContextAccesible.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by yogasawara@stv on 2017/11/05.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import UIKit

protocol ImageSearchContextAccesible {
    var imageSearchContext:FlickrImageSearchContext{get}
}

extension ImageSearchContextAccesible{
    var imageSearchContext:FlickrImageSearchContext{
        return (UIApplication.shared.delegate as! AppDelegate).imageSearchContext
    }
}

extension SearchViewController:ImageSearchContextAccesible{}
