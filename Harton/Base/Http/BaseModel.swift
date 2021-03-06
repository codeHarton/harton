//
//  BaseModel.swift
//  Goodnight
//
//  Created by zhixing on 2020/2/29.
//  Copyright © 2020 yk-mengqingling. All rights reserved.
//  BaseModel 及 ResponseData 的封装

import Foundation
public protocol CustomResponse: CustomMappable {
    var status: Int {get set}
    var error_msg: String {get set}
}
public class BaseModel: CustomMappable , CustomStringConvertible {
    required public init() { }
    public func didFinishMapping() { }
    
    public var description: String{
        
        guard let value = toJSONString() else {
            return #function
        }
        return value
    }
}

public class ResponseData<T: CustomMappable>: CustomResponse {
    
    required public init() { }
    
    public var status: Int = -1
    public var error_msg: String = ""
    public var data: T?
}

public class ResponseDataArray <T: CustomMappable>: CustomResponse {
    
    required public init() { }
    
    public var status: Int = -1
    public var error_msg: String = ""
    public var data: [T]?
}

public class ResponseAnyDataArray: CustomResponse {
    
    required public init() { }
    
    public var status: Int = -1
    public var error_msg: String = ""
    public var data: [Any]?
}

public class PageDataArray<T: CustomMappable> : CustomMappable {
    required public init() { }
    
    var page: Int = 0//当前页
    var pages: Int = 0 //总页数
    var size: Int = 0
    var total: Int = 0
    var rows: [T]?
}


extension ResponseData{
    
    ///是否成功
    var success : Bool{
        return 0 == status
    }
}

extension ResponseDataArray{
    
    ///是否成功
    var success : Bool{
        return 0 == status
    }
}


extension PageDataArray{
    //是否需要上拉刷新
    var needFooter : Bool{
        return page < pages
    }
}
