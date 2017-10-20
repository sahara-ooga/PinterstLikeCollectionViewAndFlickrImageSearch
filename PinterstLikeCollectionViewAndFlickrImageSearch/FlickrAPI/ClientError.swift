//
//  ClientError.swift
//  GithubSearchRepository
//
//  Created by yuu ogasawara on 2017/05/25.
//  Copyright © 2017年 stv. All rights reserved.
//

enum ClientError:Error {
    case connectionError(Error)
    case responseParseError(Error)
    case apiError(APIError)
}
