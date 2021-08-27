//
//  BaseModel.swift
//  Goodnight
//
//  Created by zhixing on 2020/2/29.
//  Copyright © 2020 yk-mengqingling. All rights reserved.
//  BaseModel 及 ResponseData 的封装

import Foundation
public protocol CustomResponse: CustomMappable {
    var code: Int {get set}
    var error_msg: String {get set}
}
public class BaseModel: CustomMappable {
    required public init() { }
    public func didFinishMapping() { }
}

public class ResponseData<T: CustomMappable>: CustomResponse {
    
    required public init() { }
    
    public var code: Int = -1
    public var error_msg: String = ""
    public var data: T?
}

public class ResponseDataArray <T: CustomMappable>: CustomResponse {
    
    required public init() { }
    
    public var code: Int = -1
    public var error_msg: String = ""
    public var data: [T]?
}

public class ResponseAnyDataArray: CustomResponse {
    
    required public init() { }
    
    public var code: Int = -1
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
        return 200 == code
    }
}

extension ResponseDataArray{
    
    ///是否成功
    var success : Bool{
        return 200 == code
    }
}


extension PageDataArray{
    //是否需要上拉刷新
    var needFooter : Bool{
        return page < pages
    }
}
