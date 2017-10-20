//
//  UIImage+Codable.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by Yuu Ogasa on 2017/10/20.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import UIKit

extension UIImage {
    
    private var hasAlpha: Bool {
        guard let alphaInfo = cgImage?.alphaInfo else {
            return false
        }
        
        switch alphaInfo {
        case .first, .last, .premultipliedFirst, .premultipliedLast, .alphaOnly:
            return true
        case .none, .noneSkipFirst, .noneSkipLast:
            return false
        }
    }
    
    var data: Data? {
        if hasAlpha {
            return UIImagePNGRepresentation(self)
        } else {
            return UIImageJPEGRepresentation(self, 1.0)
        }
    }
    
}
