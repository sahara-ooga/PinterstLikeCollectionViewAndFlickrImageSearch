//
//  StringExtensiionTests.swift
//  PinterstLikeCollectionViewAndFlickrImageSearchTests
//
//  Created by Yuu Ogasa on 2017/11/08.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import XCTest
@testable import PinterstLikeCollectionViewAndFlickrImageSearch

class StringExtensiionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let result = LocalizableKey.searchNoImageTitle.localized
        let expect = "There is no image"
        XCTAssertEqual(result, expect)
    }
    
}
