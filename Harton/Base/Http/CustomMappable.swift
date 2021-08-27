//
//  JsonMappable.swift
//  Goodnight
//
//  Created by zhixing on 2020/2/29.
//  Copyright © 2020 yk-mengqingling. All rights reserved.
//  自定义解析协议，方便切换 Json 解析库

import Foundation
import HandyJSON


public protocol CustomMappable: HandyJSON { }

public protocol CustomEnumMappable: HandyJSONEnum {}
