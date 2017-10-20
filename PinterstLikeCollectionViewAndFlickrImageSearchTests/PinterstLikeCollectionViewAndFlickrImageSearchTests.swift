//
//  PinterstLikeCollectionViewAndFlickrImageSearchTests.swift
//  PinterstLikeCollectionViewAndFlickrImageSearchTests
//
//  Created by Yuu Ogasa on 2017/10/20.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import XCTest
@testable import PinterstLikeCollectionViewAndFlickrImageSearch

class PinterstLikeCollectionViewAndFlickrImageSearchTests: XCTestCase {
    var callApiExpectation: XCTestExpectation? = nil
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAPIAccess() {
        self.callApiExpectation = self.expectation(description: "CallFlickrImageSearchApiAccess")
        
        // APIクライアントの生成
        let client = FlickrClient()
        
        //リクエストの発行
        let request = FlickrAPI.SearchPhotos(text: "text",
                                             page: 1,
                                             perPage: 50)
        
        // リクエストの送信
        client.send(request: request){
            result in
            XCTAssertNotNil(result)
            switch result {
            case let .success(response):
                print(response)
            case let .failure(error):
                //エラー詳細を出力
                print(error)
            }
            
            self.callApiExpectation?.fulfill()
        }
        
        self.waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
