//
//  JSONDecodeError.swift
//  GithubSearchRepository
//
//  Created by yuu ogasawara on 2017/05/25.
//  Copyright © 2017年 stv. All rights reserved.
//

import Foundation
enum JSONDecodeError:Error {
    case invalidFormat(json:Any)
    case missingValue(key:String,actualValue:Any?)
}
