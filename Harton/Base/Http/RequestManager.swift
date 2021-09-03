//
//  RequestManager.swift
//  Harton
//
//  Created by harton on 2021/9/3.
//

import UIKit
import Moya
class RequestManager: NSObject {

    
    public static func request<T : CustomMappable>(_ service : TargetType,type : T.Type,complete : @escaping(_ response : T) ->Void){
        APIProvider.request(service.muTarget) { result in
            
        }
    }
}
