//
//  FlickrImageFetchResponse.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by Yuu Ogasa on 2017/10/20.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import UIKit

struct FlickrImageFetchResponse {
    let image:UIImage?
}

extension FlickrImageFetchResponse:Encodable{
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        if let image = image, let imageData = image.data {
            let imageDataBase64String = imageData.base64EncodedString()
            try container.encode(imageDataBase64String, forKey: .image)
        }
    }

}

extension FlickrImageFetchResponse:Decodable{
    enum CodingKeys: String, CodingKey {
        case image
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let imageDataBase64String = try values.decode(String.self, forKey: .image)
        if let data = Data(base64Encoded: imageDataBase64String) {
            image = UIImage(data: data)
        } else {
            image = nil
        }
    }
}
