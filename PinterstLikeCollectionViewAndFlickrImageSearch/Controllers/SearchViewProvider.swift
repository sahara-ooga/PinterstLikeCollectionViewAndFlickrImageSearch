//
//  SearchViewProvider.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by Yuu Ogasa on 2017/10/31.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import UIKit

final class SearchViewProvider{
    //TODO: Diskで読み込んだデータで初期化する
    var photos = [UIImage]()
}

extension SearchViewProvider:PinterestLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return self.photos[indexPath.item].size.height
    }
}
