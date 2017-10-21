//
//  FlickrImageSearchAndFetchTests.swift
//  FlickrImageSearchAndFetchTests
//
//  Created by Yuu Ogasa on 2017/10/20.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import XCTest
@testable import PinterstLikeCollectionViewAndFlickrImageSearch

class FlickrImageSearchAndFetchTests: XCTestCase {
    var callApiExpectation: XCTestExpectation? = nil
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchPhotos() {
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
    
    func testFetchImage(){
        self.callApiExpectation = self.expectation(description: "CallFlickrImageFetchApiAccess")
        
        // APIクライアントの生成
        let client = FlickrClient()
        
        //リクエストの発行
        let photo = FlickrImageSearchResponse.Photos.Photo(id: "37754664646", owner: "8467288@N02", secret: "7f8002d303", server: "4510", farm: 5, title: "DSC02871", ispublic: 1, isfriend: 0, isfamily: 0)
        let baseURL = URL(string:"https://farm" + String(photo.farm) + ".staticflickr.com")!
        let path = photo.server + "/" + photo.id + "_" + photo.secret + ".jpg"
        let request = FlickrAPI.FetchPhoto(baseURL: baseURL,
                                           path:path,
                                           parameters: nil)
        // リクエストの送信
        client.send(request: request){
            //In this closure, transmission　has ended.
            result in
                XCTAssertNotNil(result)
                switch result {
                case let .success(response):
                    print(response.image!)
                case let .failure(error):
                    //エラー詳細を出力
                    print(error)
                }
            
                self.callApiExpectation?.fulfill()
        }
        
        self.waitForExpectations(timeout: 20, handler: nil)
    }
    
}
