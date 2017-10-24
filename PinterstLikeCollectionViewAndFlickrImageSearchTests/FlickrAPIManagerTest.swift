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
    var callApiExpectation: XCTestExpectation? = nil

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
        self.callApiExpectation = self.expectation(description: "CallFlickrImageSearchApiAccess")

        apiManager.search(searchWord,to:page, perPage:perPage){//argument is FlickrImageSearchResponse
            XCTAssertNotNil($0)
            self.callApiExpectation?.fulfill()
        }
        self.waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testFetchPhotos() {
        let photo = TestCommonDefines.photo
        self.callApiExpectation = self.expectation(description: "CallFlickrImageSearchApiAccess")
        
        apiManager.fetch(to: URL(string:photo.imageURL)!){image in
            guard image != nil else {
                            XCTFail("no images.")
                            return
                        }
            self.callApiExpectation?.fulfill()
                    }
        
        self.waitForExpectations(timeout: 20, handler: nil)

    }
    
    func testFetch() {
        let photo = TestCommonDefines.photo
        let photos = Photos(page: 1, pages: 1, perpage: 1, total: "1", photo: [photo])
        let response = FlickrImageSearchResponse(photos: photos, stat: "ok")
        self.callApiExpectation = self.expectation(description: "CallFlickrImageSearchApiAccess")
        apiManager.fetch(for: response){images in
            XCTAssertFalse((images!.isEmpty))
            self.callApiExpectation?.fulfill()
        }
        self.waitForExpectations(timeout: 20, handler: nil)

    }
}