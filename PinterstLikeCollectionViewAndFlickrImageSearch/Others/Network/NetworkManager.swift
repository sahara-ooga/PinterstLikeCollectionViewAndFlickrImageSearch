//
//  NetworkManager.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2016/12/18.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import Foundation

final class NetworkManager {

    static func isAvailable() -> Bool{

        let net = NetworkReachabilityManager()
        net?.startListening()

        if net?.isReachable ?? false {
            return true

        } else {
            return false
        }
    }
}
