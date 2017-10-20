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
    
//    init(jsonData:Any)throws {
//        guard let dictionary = jsonData as? [String:Any] else {
//            throw JSONDecodeError.invalidFormat(json: json)
//        }
//
//        guard let message = dictionary["message"] as? String else {
//            throw JSONDecodeError.missingValue(key: "message",
//                                               actualValue: dictionary["message"])
//        }
//
//        let fieldErrorObjects = dictionary["errors"] as? [Any] ?? []
//
//        let fieldErrors = try fieldErrorObjects.map{
//            return try FieldError(json: $0)
//        }
//
//        self.message = message
//        self.fieldErrors = fieldErrors
//    }
//
//    init(from decoder: Decoder) throws {
//        <#code#>
//    }
//
//    func encode(to encoder: Encoder) throws {
//        <#code#>
//    }
}

extension APIError{
    struct FieldError:Codable {
        let resource:String
        let field:String
        let code:String
        
//        init(json:Any) throws {
//
//            guard let dictionary = json as? [String : Any] else {
//                throw JSONDecodeError.invalidFormat(json: json)
//            }
//
//            guard let resource = dictionary["resource"] as? String else {
//                throw JSONDecodeError.missingValue(
//                    key: "resource",
//                    actualValue: dictionary["resource"])
//            }
//
//            guard let field = dictionary["field"] as? String else {
//                throw JSONDecodeError.missingValue(
//                    key: "field",
//                    actualValue: dictionary["field"])
//            }
//
//            guard let code = dictionary["code"] as? String else {
//                throw JSONDecodeError.missingValue(
//                    key: "code",
//                    actualValue: dictionary["code"])
//            }
//
//            self.resource = resource
//            self.field = field
//            self.code = code
//        }
        
        
    }
}
