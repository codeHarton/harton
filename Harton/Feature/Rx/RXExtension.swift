//
//  RXExtension.swift
//  Harton
//
//  Created by harton on 2021/8/27.
//

import UIKit

import Moya
import RxSwift


extension ObservableType{
    func _subscribe(onNext: ((Self.Element) -> Void)?) ->RxSwift.Disposable{
        return subscribe(onNext: onNext)
    }
}
public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    
   
    /// Maps data received from the signal into a JSON object. If the conversion fails, the signal errors.
    func mapObject<T:CustomMappable>(type : T.Type) -> Single<T> {
        return flatMap { value in
            guard let obj = try? value.mapModel(type) as? T else{
                throw MoyaError.jsonMapping(value)
            }
            return .just(obj)
        }
    }
   
}

extension Moya.Response{
    func mapModel<T: CustomMappable>(_ type: T.Type) throws -> CustomMappable {
        guard let json = (try? mapJSON()) as? [String: Any],
            let object = type.deserialize(from: json) else {
                throw MoyaError.jsonMapping(self)
        }
        return object
    }
}
