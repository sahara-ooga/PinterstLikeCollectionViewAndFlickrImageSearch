//
//  APIError.swift
//  GithubSearchRepository
//
//  Created by yuu ogasawara on 2017/05/25.
//  Copyright © 2017年 stv. All rights reserved.
//

struct APIError:Error,Codable {
    let message:String
    let fieldErrors:[FieldError]
}

extension APIError{
    struct FieldError:Codable {
        let resource:String
        let field:String
        let code:String
    }
}
