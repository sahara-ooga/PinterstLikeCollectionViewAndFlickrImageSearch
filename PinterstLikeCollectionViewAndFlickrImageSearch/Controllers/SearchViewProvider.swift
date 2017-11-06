//
//  SearchViewProvider.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by Yuu Ogasa on 2017/10/31.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import UIKit

final class SearchViewProvider:NSObject{
    //TODO: Diskで読み込んだデータで初期化する
    private var photos = [UIImage]()
}

// MARK: - Manage photos
extension SearchViewProvider{
    func append(_ photos:[UIImage]) {
        self.photos += photos
    }
    
    func makesPhotosEmpty(){
        self.photos.removeAll()
    }
}
extension SearchViewProvider:UICollectionViewDataSource{
    /// セクション数を返す
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if photos.count == 0{
//            let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCell.identifier,
//                                                               for: indexPath) as! EmptyCell
//            return emptyCell
//        }
        
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier,
                                                      for: indexPath) as! PhotoCell
        photoCell.image = photos[indexPath.item]
        return photoCell
    }
    
}

extension SearchViewProvider:PinterestLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return self.photos[indexPath.item].size.height
    }
}
