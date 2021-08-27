//
//  MoyaProvider+CustomConfig.swift
//  Goodnight
//
//  Created by yk-mengqingling on 2020/2/28.
//  Copyright © 2020 yk-mengqingling. All rights reserved.
//  防抓包配置

import Foundation
import Moya

extension MoyaProvider {
    final class func customAlamofireManager() -> Session {
        let configuration = URLSessionConfiguration.default
        configuration.connectionProxyDictionary = [:]
        let manager = Session(configuration: configuration, startRequestsImmediately: false)
        return manager
    }
}
