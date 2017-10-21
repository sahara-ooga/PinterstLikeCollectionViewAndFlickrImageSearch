//
//  TestCommonDefines.swift
//  PinterstLikeCollectionViewAndFlickrImageSearchTests
//
//  Created by yogasawara@stv on 2017/10/21.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import Foundation
@testable import PinterstLikeCollectionViewAndFlickrImageSearch

struct TestCommonDefines {
    static let photo = Photo(id: "37754664646",
                                                              owner: "8467288@N02",
                                                              secret: "7f8002d303",
                                                              server: "4510",
                                                              farm: 5,
                                                              title: "DSC02871",
                                                              ispublic: 1,
                                                              isfriend: 0,
                                                              isfamily: 0)
    
    static let baseURL = URL(string:"https://farm" + String(photo.farm) + ".staticflickr.com")!
    
    static let path = photo.server + "/" + photo.id + "_" + photo.secret + ".jpg"
}
