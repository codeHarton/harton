//
//  RXEXTViewController.swift
//  Harton
//
//  Created by harton on 2021/9/11.
//

import UIKit
import Moya
class RXEXTViewController: BaseViewController {
    
    
    let pipe = ValuePipe<Int>()
    
    var sig1 : Harton.Disposable?
    
    var sig2 : Harton.Disposable?
    
    var value = Promise<Int>()
    
    var iValue = Promise(initializeOnFirstAccess: Signal<Int,NoError>({ sub in
        ActionDisposable {
            
        }
    }))
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }
    
    
    func test1(){
        
        //        sig2 = (fetchData() |> Harton.then(fetchData1())).start { model in
        //            print("收到数据")
        //        } error: { error in
        //            error.log()
        //        }
        //       ( pipe.signal() |> `catch` { e in
        //
        //        return .fail(e)
        //
        //
        //       } |> restart) |> take(1)
        //
        
        
        
//        (deferred {() -> Signal<Int,MyError> in
//            return .fail(.none)
//        } |> mapToSignal { value in
//            return .single(value)
//        }).start()
//
//
//        sig2 = (fe(value: 2) |> retry(1, maxDelay: 10, onQueue: .mainQueue())).start { value in
//            print( "fetchResult = \(value)")
//        } error: { error in
//            print("error = \(error)")
//        } completed: {
//            print( "completed")
//        }
//
//
//        (fetchData() |> filter({ value in
//            return value.info != nil
//        })).start()
//
//
//        (fetchData() |> map{value  in
//            return value.info?.count
//        })
//
//
//        (Signal<Int?,MyError>({sub in
//            return ActionDisposable {
//
//            }
//        }) |> mapError { error in
//            return MyError.none
//        } |> distinctUntilChanged{ left ,right in
//            return left == right
//        }).start()
//
//
//        (fetchData() |> `catch` { error ->Signal<ListModel,MyError> in
//            return Signal { sub in
//                ActionDisposable {
//
//                }
//            }
//        } |> retry(retryOnError: { error in
//            return false
//        }, delayIncrement: 1, maxDelay: 1, maxRetries: 1, onQueue: .mainQueue()))
//
//
        let count = Atomic(value: 1)

        count.modify { value  in
            return 1
        }.log()
        
        count.swap(3).log()
        
        count.get().log()

        let thenSig = Signal<Int,NoError>({ sub  in
            print("thenSig")
            sub.putNext(100)
            sub.putCompletion()
            
           return   ActionDisposable {
                
            }
        })
        
        
        
        (Signal<Int,Error> { sub in
//            APIProvider.rx.request(HartonService.getList(params: [:]).muTarget).mapObject(type: ListModel.self).subscribe { list in
//                sub.putNext(list)
//                sub.putCompletion()
//            } onError: { error  in
//                sub.putError(error)
//            }.disposed(by: self.rx.disposeBag)
            Queue.mainQueue().after(1) {
                if Bool.random(){
                    sub.putNext(1)
                    sub.putCompletion()
                }else{
                    sub.putError(MyError.none)
                }
            }
            return ActionDisposable {
            }
        } |> restartIfError(_:) |> Harton.then(thenSig)).start { value  in
            value.log()
        } error: { error in
            print("error")
        } completed: {
            "complete".log()
        }

        
        thenSig |> take{ value in
            return SignalTakeAction(
            
        }

        
    }
    

    
    private func _recursiveFunction(_ f: @escaping(@escaping() -> Void) -> Void) -> (() -> Void) {
        print(#function)
        return {
            f(self._recursiveFunction(f))
        }
    }
    
    func fe(value : Int) ->Signal<Int,Error>{
        return Signal { sub in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                sub.putError(MyError.none)
            }
            return ActionDisposable {
                print(#function)
            }
        }
    }
    
    
    
    
    deinit {
        sig2?.dispose()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pipe.putNext(200)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func fetchData() ->Signal<ListModel,Error>{
        return Signal { sub in
            APIProvider.rx.request(HartonService.getList(params: ["page":1]).muTarget).mapObject(type: ResponseData<ListModel>.self).subscribe { response in
                guard let data = response.data else{
                    sub.putError(MyError.none)
                    return
                }
                sub.putNext(data)
                sub.putCompletion()
            } onError: { error in
                sub.putError(error)
            }.disposed(by: self.rx.disposeBag)
            return ActionDisposable {
                print(type(of: self).description(),#function)
            }
        }
    }
    
    
    func fetchData1() ->Signal<ListModel,Error>{
        return Signal { sub in
            APIProvider.rx.request(HartonService.getList(params: ["page":1]).muTarget).mapObject(type: ResponseData<ListModel>.self).subscribe { response in
                guard let data = response.data else{
                    sub.putError(MyError.none)
                    return
                }
                sub.putNext(data)
                sub.putCompletion()
            } onError: { error in
                sub.putError(error)
            }.disposed(by: self.rx.disposeBag)
            return ActionDisposable {
                print(type(of: self).description(),#function)
            }
        }
    }
    
}

enum MyError : Error{
    case none
}
