//
//  AlertMessageDelegate.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by Yuu Ogasa on 2017/11/01.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//
import UIKit

protocol AlertMessageDelegate : class {
    func completeActionAlertMessage(action: UIAlertAction, nextSelector: Selector?)
}
