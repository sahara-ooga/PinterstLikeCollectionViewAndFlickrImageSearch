//
//  FlickrImageSearchContextTests.swift
//  PinterstLikeCollectionViewAndFlickrImageSearchTests
//
//  Created by Yuu Ogasa on 2017/11/02.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import XCTest
@testable import PinterstLikeCollectionViewAndFlickrImageSearch

class FlickrImageSearchContextTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIsReachable() {
        XCTAssertTrue(FlickrImageSearchContext.isReachable())
    }
    
    
}
