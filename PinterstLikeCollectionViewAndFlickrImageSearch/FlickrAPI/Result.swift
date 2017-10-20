//
//  Result.swift
//  GithubSearchRepository
//
//  Created by yuu ogasawara on 2017/05/26.
//  Copyright © 2017年 stv. All rights reserved.
//

enum Result<T,Error:Swift.Error> {
    case success(T)
    case failure(Error)
    
    init(value:T) {
        self = .success(value)
    }
    
    init(error:Error) {
        self = .failure(error)
    }
}
