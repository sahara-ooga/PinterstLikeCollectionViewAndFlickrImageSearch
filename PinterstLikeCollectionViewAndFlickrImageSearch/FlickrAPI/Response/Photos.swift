//
//  Photos.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by yogasawara@stv on 2017/10/21.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import Foundation

struct Photos: Codable {
    //何ベージ目の検索結果か？
    let page: Int
    
    //全部で何ページあるのか？
    let pages: Int
    
    //１ページあたり何件あるのか？
    let perpage: Int
    
    //合計で何件あるか？
    let total: String
    
    //検索結果
    let photoInfos:[Photo]
    
    /*
     NOTE:
     - photoInfos.count <= perpage(ページあたりの検索結果件数設定)
     - total <= pages * perpage (検索結果の総数　<= 総ベージ数　× １ページあたりの検索結果件数）
     - 今最後のページかどうか：page == pages なら true; page < pages ならfalse
     - まだページが残っているかどうか：page < pages なら true; page == pages なら false
     */
    
    private enum CodingKeys:String,CodingKey{
        case page
        case pages
        case perpage
        case total
        case photoInfos = "photo" //外部キーとのマッピングを明示的に指定
    }
}
