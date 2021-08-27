//
//  HartonService.swift
//  Harton
//
//  Created by harton on 2021/8/27.
//

import UIKit

import Moya
enum HartonService {
    ///获取分类列表
    case getCategories
    
    case getList
    ///检查更新
    case checkUpdate
    
    case report(params : [String : Any])
    
    case checkFile(params : [String : Any])
    
}

extension HartonService : TargetType{
    var headers: [String : String]? {
        return nil
    }
    
    
    var baseURL: URL {
        switch self {
        case .report:
            return URL(string: "http://logs.v.feihuo.com")!
        default:
            return URL(string: "https://bizhi.feihuo.com")!
        }
        
    }
    var path: String{
        switch self {
        case .report:
            return ""
        case .getCategories:
            return "/pc/api/GetCategories"
        case .getList:
            return "/pc/v/list"
        case .checkUpdate:
            return "/pc/api/checkVersion"
        case .checkFile:
            return "/pc/fhbzApi/checkFile"
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .checkUpdate,
             .report:
            return .post
        default:
            return .get
        }
        
    }
    
    var task: Task{
        switch self {
        case .checkUpdate:
            return .requestParameters(parameters: ["channel":"appstore"], encoding: URLEncoding.default)
        case let .report(params: params),
             let .checkFile(params: params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
        
    }
    
    var sampleData: Data{
        return Data()
    }
}

