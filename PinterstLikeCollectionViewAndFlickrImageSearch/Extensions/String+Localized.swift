//
//  String+Localized.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by Yuu Ogasa on 2017/11/08.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import UIKit
extension String{
    var localized:String{
        return NSLocalizedString(self, comment: "")
    }
}
