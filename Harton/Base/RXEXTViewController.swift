//
//  RXEXTViewController.swift
//  Harton
//
//  Created by harton on 2021/9/11.
//

import UIKit
import Moya
import RxSwift
import RxCocoa
extension RxSwift.Disposable {
    func autoDis(){
    

//        disposed(by: rx.disposeBag)
    }
}

extension Harton.Disposable{
    func dispose(by set : DisposableSet){
        set.add(self)
    }
}

class RXEXTViewController: BaseViewController {
    
    
    let pipe = ValuePipe<Int>()
    
    var sig1 : Harton.Disposable?
    
    var sig2 : Harton.Disposable?
    
    var value = Promise<Int>()
    
    let bag = Bag<Int>()
    
    
    var dSet = DisposableSet()
    
    var iValue = Promise(initializeOnFirstAccess: Signal<Int,NoError>({ sub in
            sub.putNext(1000)
            sub.putCompletion()
        return ActionDisposable {
            print("value dispose")
        }
    }))
    
    
    
    let vPromise = ValuePromise<Bool>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let _s1 = Signal<Int,NoError> { sub in
            Observable<Int>.interval(1, scheduler: MainScheduler.instance)._subscribe {value  in
                sub.putNext(value)
            }
            return ActionDisposable {
                
            }
        }
        
        let _s2 = Signal<Int,NoError> { sub in
            Observable<Int>.interval(2, scheduler: MainScheduler.instance)._subscribe {value  in
                sub.putNext(value * 100)
            }
            return ActionDisposable {
                
            }
        }
        
        (Signal<Signal<Int,NoError>,NoError> { sub in
            sub.putNext(_s1)
            sub.putNext(_s2)
            sub.putNext(_s1)
            return ActionDisposable {
                
            }
        } |> switchToLatest(_:)).start { value  in
            print("value = \(value)")
        }
        
        
        
        
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       

    }

    deinit {
        print(#function)
        sig1?.dispose()
        sig2?.dispose()
    }
    
    func test4(){
        (Signal<Int,MyError>{sub  in
            Queue.mainQueue().after(1) {
                sub.putError(.none)
            }
            return ActionDisposable {
                print("____error-dis")
            }
        } |> restartIfError(maxCount:3)).start { value in
            print("----\(value)")
        } error: { error in
            error.description.log()
        } completed: {
            
        }.dispose(by: dSet)
        
        
        Signal<Int,NoError> { sub  in
            return ActionDisposable {
                print("----dis")
            }
        }.start().dispose(by: dSet)

    }
    
    func test3(){
        let textField = UITextField()
        textField.placeholder = "combineLaster"
        self.view.addSubview(textField)
        textField.snp.makeConstraints{$0.centerX.equalToSuperview();$0.centerY.equalToSuperview().offset(44);$0.left.height.equalTo(44)}

        
      
        dSet.add(combineLatest(textField.signal, Signal<Int,NoError>({ sub  in
            Queue.mainQueue().after(2) {
                sub.putNext(100)
            }
            Queue.mainQueue().after(4) {
                sub.putNext(100)
            }
            Queue.mainQueue().after(6) {
                sub.putNext(100)
            }
            Queue.mainQueue().after(8) {
                sub.putNext(100)
            }
            Queue.mainQueue().after(11) {
                sub.putCompletion()
            }
            return ActionDisposable {
                print("----dis")
            }
        })).start { (value1, value2) in
            print("combinelaste = \(value1)  value2 = \(value2)")
        })
        
        self.bag.add(1)
        
        
        let v = self.bag.get(10)
        
        
    }
    
    
    func test2(){
        (iValue.get() |> afterCompleted{}).start()
        
        
        iValue.get().start { value  in
            value.log()
        } completed: {
            "1complete".log()
        }
        
        combineLatest([iValue.get(),iValue.get()]).start { value  in
            print("combine = \(value)")
        } completed: {
            
        }

    
        let textField = UITextField()
        self.view.addSubview(textField)
        textField.snp.makeConstraints{$0.centerX.equalToSuperview();$0.centerY.equalToSuperview().offset(44);$0.left.height.equalTo(44)}
        textField.signal.start { value in
            value.log()
        }
        
      

        
        let button = UIButton(type: .contactAdd)
        self.view.addSubview(button)
        button.snp.makeConstraints{$0.center.equalToSuperview()}
        button.rx.controlEvent(.touchUpInside)._subscribe {
            
            self.iValue.set(Signal({ sub in
                sub.putNext(200)
                Queue.mainQueue().after(2) {
                    sub.putCompletion()
                }
                return ActionDisposable {
                    print("dis ===== set")
                }
                
            }))
        }.disposed(by: rx.disposeBag)
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

        
        
        Signal<Int,NoError> { sub in
            sub.putNext(1)
            Queue.mainQueue().after(1) {
                sub.putCompletion()
            }
            return EmptyDisposable
        }.start { value in
            
        } completed: {
            
        }
        
        
        let textField = UITextField()
        textField.signal.start { value in
            value.log()
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

enum MyError : Error ,CustomStringConvertible{
    case none
    
    var description: String{
        return "none"
    }
    
    
}

extension UITextField{
    var signal : Signal<String,NoError>{
        return Signal { sub in
            let dispose = self.rx.text.orEmpty._subscribe { value in
                sub.putNext(value)
            }
            return ActionDisposable {
                print(#function)
                dispose.dispose()
            }
        }
    }
}
