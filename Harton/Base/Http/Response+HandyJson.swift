//
//  Response+HandyJson.swift
//  Goodnight
//
//  Created by zhixing on 2020/2/29.
//  Copyright © 2020 yk-mengqingling. All rights reserved.
//

import UIKit
import Moya
import HandyJSON

public extension Response {
    
    /// Maps data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
    func mapObject<T: CustomMappable>(_ type: T.Type) throws -> CustomMappable {
        guard let json = (try? mapJSON()) as? [String: Any],
            let object = type.deserialize(from: json) else {
                throw MoyaError.jsonMapping(self)
        }
        return object
    }
}
