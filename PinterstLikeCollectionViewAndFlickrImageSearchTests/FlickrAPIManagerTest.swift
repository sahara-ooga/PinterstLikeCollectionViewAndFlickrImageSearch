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

        apiManager.search(searchWord,to:page, perPage:perPage){result in
            
            switch result{
            case .success(let response):
                XCTAssertEqual(response.photos.photoInfos.count,perPage)
                self.callApiExpectation?.fulfill()
            default:
                XCTFail("fail to search keyword.")
            }
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
        let photos = Photos(page: 1, pages: 1, perpage: 1, total: "1", photoInfos: [photo])
        let response = FlickrImageSearchResponse(photos: photos, stat: "ok")
        self.callApiExpectation = self.expectation(description: "CallFlickrImageSearchApiAccess")
        apiManager.fetch(for: response){result in
            switch result{
            case .success(let images):
                XCTAssertFalse((images.isEmpty))
                self.callApiExpectation?.fulfill()
            default:
                XCTFail("error at fetching for response")
            }
            
        }
        self.waitForExpectations(timeout: 20, handler: nil)

    }
    
    func testGetImageOfKeyword() {
        //fetch images from keyword
        let keyword = "tokyo"
        let expectedNumOfImage = 50
        
        self.callApiExpectation =
            self.expectation(description: "Get image from keyword")

        apiManager.getImage(of:keyword){ result in
            switch result{
            case .success(let images):
                XCTAssert(images.count >= expectedNumOfImage)
                self.callApiExpectation?.fulfill()
            case .failure(let error):
                print(error)
                XCTFail("fail to get images from keyword.")
            }
            
        }

        self.waitForExpectations(timeout: 20, handler: nil)
    }
}

