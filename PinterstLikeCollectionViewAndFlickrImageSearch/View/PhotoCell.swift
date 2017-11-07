//
//  PhotoCell.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by yogasawara@stv on 2017/10/22.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var image:UIImage?{
        didSet{
            imageView.image = image
        }
    }
    
    static func cellSize() -> CGSize {
        let margin: CGFloat = 10
        let screenSize = UIScreen.main.bounds
        let screenPerWidth: CGFloat = 2 //3
        let screenPerHeight: CGFloat = 5
        
        let cellWidth = (screenSize.width - margin) / screenPerWidth
        let cellHeight = (screenSize.height - margin) / screenPerHeight
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        //delete image before reuse
        self.imageView.image = nil
    }
}
