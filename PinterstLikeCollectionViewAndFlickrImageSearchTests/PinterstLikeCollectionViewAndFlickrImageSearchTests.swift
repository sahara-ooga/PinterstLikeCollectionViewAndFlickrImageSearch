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
    
    func testFetchImage() {
        let session:URLSession = {
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            return session
        }()
        
        self.callApiExpectation = self.expectation(description: "CallFlickrImageFetchAccess")
                
        //(id: "37754664646", owner: "8467288@N02", secret: "7f8002d303", server: "4510", farm: 5, title: "DSC02871", ispublic: 1, isfriend: 0, isfamily: 0)
        let photo = FlickrImageSearchResponse.Photos.Photo(id: "37754664646", owner: "8467288@N02", secret: "7f8002d303", server: "4510", farm: 5, title: "DSC02871", ispublic: 1, isfriend: 0, isfamily: 0)
        
        let request = FlickrAPI.FetchPhoto(baseURL: URL(string: photo.imageURL)!,
                                           parameters: nil)
        var urlRequest = URLRequest(url: request.baseURL)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        let task = session.dataTask(with: urlRequest)
                                    {data,response,error in
                                        
                                        switch (data,response,error){
                                        case (_, _, let error?):
                                            //completion(Result(error: .connectionError(error)))
                                            XCTFail("connection error.")
                                        case (let data?, let response?, _):
                                            do {
                                                let r = try request.response(from: data,
                                                                                    urlResponse: response)
                                                //completion(Result(value: response))
                                                r.image
                                                self.callApiExpectation?.fulfill()
                                            } catch let error as APIError{
                                                //completion(Result(error: .apiError(error)))
                                            } catch{
                                                //completion(Result(error: .responseParseError(error)))
                                            }
                                            
                                        default:
                                            fatalError("invalid response combination \(String(describing: data)), \(String(describing: response)), \(String(describing: error)).)")
                                        }
        }
        
        task.resume()
        
//        client.send(request: request){
//            result in
//                XCTAssertNotNil(result)
//                switch result {
//                case let .success(response):
//                    XCTAssertNotNil(response.image)
//                case let .failure(error):
//                    //エラー詳細を出力
//                    print(error)
//            }
//
//            self.callApiExpectation?.fulfill()
//        }
        
        self.waitForExpectations(timeout: 20, handler: nil)
    }
    
}
