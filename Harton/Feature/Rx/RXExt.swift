//
//  RXExt.swift
//  Harton
//
//  Created by harton on 2021/9/10.
//

import UIKit
import RxSwiftExt
import RxSwift
import ReactiveCocoa
enum HeError : Error {
    case none
}
class RXExt: NSObject {

    func rac(){
       
        
        let sig = Harton.Signal<Int,HeError> { sub in
            return ActionDisposable {
                
            }
        }
    
        (sig |> take(10))
        Harton.take(10)(sig)

        (sig |> take{
            SignalTakeAction(passthrough: $0 > 5, complete: false)
        }).start { value in
            
        } error: { error in
            
        } completed: {
            
        }
        
        
        Harton.last(signal: sig)


        
    }
    func run(){

        let ob = Observable.just(false)
        ob.apply { value in
            return Observable<Result>.create { sub in
                value.subscribe { res in
                    sub.onNext(Result<Bool,HeError>.success(false))
                } onError: { error in
                    sub.onError(HeError.none)
                } onCompleted: {
                    sub.onCompleted()
                } onDisposed: {
                    
                }

            }
        }
    }
}
