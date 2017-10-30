//
//  Photos.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by yogasawara@stv on 2017/10/21.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import Foundation

struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photoInfos:[Photo]
    
    private enum CodingKeys:String,CodingKey{
        case page
        case pages
        case perpage
        case total
        case photoInfos = "photo" //外部キーとのマッピングを明示的に指定
    }
}
