//
//  PinterestLayout.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by yogasawara@stv on 2017/10/29.
//  Thanks to https://www.raywenderlich.com/164608/uicollectionview-custom-layout-tutorial-pinterest-2
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import UIKit

/// protocol that will provide to PinterestLayout information, which is needed for calculating the height of every item, since you don’t know what the height of the photo will be in advance.
protocol PinterestLayoutDelegate: class {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat
}

// MARK: - Define Properties
class PinterestLayout: UICollectionViewLayout {
    weak var delegate: PinterestLayoutDelegate!
    
    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 6
    
    //When you call prepare(), you’ll calculate the attributes for all items and add them to the cache.
    //When the collection view later requests the layout attributes, you can be efficient and query the cache instead of recalculating them every time.
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    //incremented as photos are added.
    fileprivate var contentHeight: CGFloat = 0

    //calculated based on the collection view width and its content inset
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    //return the size of the collection view’s contents.
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
}

extension PinterestLayout{
    override func prepare() {
        //only calculate the layout attributes if cache is empty and the collection view exists.
        guard cache.isEmpty == true,
            let collectionView = collectionView else {
            return
        }
        
        // 2
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        // 3
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            // 4
            let photoHeight = delegate.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath)
            let height = cellPadding * 2 + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // 6
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
}
