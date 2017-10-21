//
//  FlickrAPIManagerTest.swift
//  PinterstLikeCollectionViewAndFlickrImageSearchTests
//
//  Created by yogasawara@stv on 2017/10/21.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import XCTest
@testable import PinterstLikeCollectionViewAndFlickrImageSearch

class FlickrAPIManagerTest: XCTestCase {
    let apiManager = FlickrAPIManager()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchPhotoInfo() {
        // as a whole,
        // argumenta are
        // keyword,page,perPage,and completionHandler
        let searchWord = "train"
        let page = 1
        let perPage = 50
        //perPage default value = 50
        apiManager.search(searchWord,to:page, perPage:perPage){//argument is FlickrImageSearchResponse
            XCTAssertNotNil($0)
        }

    }
    
    func testFetchPhotos() {
        let photo = TestCommonDefines.photo
        let photos = FlickrImageSearchResponse.Photos(page: 1, pages: 3, perpage: 50, total: "150", photo: [photo])
        let searchResponse = FlickrImageSearchResponse(photos: photos, stat: "1")
        
    }
    
}
