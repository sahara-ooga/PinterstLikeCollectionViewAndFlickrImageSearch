//
//  Identifier.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by Yuu Ogasa on 2017/10/31.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import Foundation

protocol Identifier {
    
}

extension Identifier{
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
    
    static var nibName: String {
        get {
            return self.identifier
        }
    }
}

extension PhotoCell:Identifier{}
extension EmptyCell:Identifier{}
