//
//  GitHubClient.swift
//  GithubSearchRepository
//
//  wrap URLSession.
//
//
//  Created by yuu ogasawara on 2017/05/26.
//  Copyright © 2017年 stv. All rights reserved.
//

import Foundation

class FlickrClient {
    var session:URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    func send<R:Request>(request:R,
              completion:@escaping (Result<R.Response, ClientError>) -> Void){
        
        let urlRequest = request.buildURLRequest()
        
        let task = session.dataTask(with: urlRequest,
                                    completionHandler: {data,response,error in
                                        
                                        switch (data,response,error){
                                        case (_, _, let error?):
                                            if let clientError = error as? ClientError{
                                                completion(Result(error: clientError))
                                            }
                                            completion(Result(error: .connectionError(.isNotReachable)))
                                            
                                        case (let data?, let response?, _):
                                            do {
                                                let response = try request.response(from: data,
                                                                                    urlResponse: response)
                                                completion(Result(value: response))
                                            } catch let error as APIError{
                                                completion(Result(error: .apiError(error)))
                                            } catch let error as ResponseError{
                                                completion(Result(error: .responseParseError(error)))
                                            } catch {
                                                print(error)
                                            }
                                            
                                        default:
                                            fatalError("invalid response combination \(String(describing: data)), \(String(describing: response)), \(String(describing: error)).)")
                                        }
        })
        
        task.resume()
    }
    
    func cancel(){
        session.invalidateAndCancel()
        print("canceled session.")
        session = urlSession()
    }
    
    private func urlSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }
}
