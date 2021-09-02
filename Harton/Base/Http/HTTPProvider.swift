//
//  HTTPRequest.swift
//  Goodnight
//
//  Created by yk-mengqingling on 2020/2/28.
//  Copyright © 2020 yk-mengqingling. All rights reserved.
//  MoyaProvider 封装

import Foundation
import Moya
import ProgressHUD
// MARK: - APIProvider 自定义相关
private let networkLoggerPlugin: NetworkLoggerPlugin = {
    let config = NetworkLoggerPlugin.Configuration(logOptions: NetworkLoggerPlugin.Configuration.LogOptions.verbose)
    return NetworkLoggerPlugin(configuration: config)
}()

private let networkActivityPlugin = NetworkActivityPlugin { (change, target) -> () in
    switch(change){
    case .began:
        DispatchQueue.main.async(execute: {
            ProgressHUD.show("加载中...")
        })
    case .ended:
        DispatchQueue.main.async(execute: {
            ProgressHUD.showSuccess("成功")
            ProgressHUD._dismiss()
        })
    }
}

private let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        //设置请求时长
        request.timeoutInterval = 30
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

#if DEBUG
let APIProvider = MoyaProvider<MultiTarget>(requestClosure: requestClosure, stubClosure: MoyaProvider.neverStub, plugins: [networkLoggerPlugin, networkActivityPlugin])
#else
let APIProvider = MoyaProvider<MultiTarget>(requestClosure: requestClosure, session: MoyaProvider<MultiTarget>.customAlamofireManager(), plugins: [networkLoggerPlugin, networkActivityPlugin])
#endif


// MARK: - APIProvider 请求实例
public class HTTPProvider {
    
    typealias HTTPResult = (CustomMappable?, MoyaError?) -> Void
    
    class func request<T: CustomMappable>(target: MultiTarget, type: T.Type, completion: @escaping HTTPResult) {
        
        APIProvider.request(target, callbackQueue: nil, progress: nil) { (result) in
            switch result {
            case let .success(response):
                do {
                    let object = try response.mapObject(type)
                    completion(object, nil)
                } catch let error {
                    completion(nil, error as? MoyaError)
                }
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}
