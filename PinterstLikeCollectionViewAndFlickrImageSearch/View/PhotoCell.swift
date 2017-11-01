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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        //delete image before reuse
        self.imageView.image = nil
    }
}
