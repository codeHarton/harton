//
//  RunLoopViewController.swift
//  Harton
//
//  Created by harton on 2021/9/3.
//

import UIKit


// MARK:问题
/**
 1. AFNetworking3.0后为什么不再需要常驻线程？//https://www.jianshu.com/p/b5c27669e2c1
 2.AFNetworking 什么情况内存泄漏
 
 
 */


//先来看看 NSURLConnection 发送请求时的线程情况，NSURLConnection 是被设计成异步发送的，调用了start方法后，NSURLConnection 会新建一些线程用底层的 CFSocket 去发送和接收请求，在发送和接收的一些事件发生后通知原来线程的Runloop去回调事件。

class RunManager {
    static func setup(){
        DispatchQueue.global().async {
            self._setup()
        }
    }
    
    static func _setup(){
        CFRunLoopObserverCreateWithHandler(nil, CFRunLoopActivity.allActivities.rawValue, true, 0) { obser , activi  in
            switch activi{
            case .entry:
                print("即将进入runloop");
                break;
            case .beforeTimers:
                print("即将处理timer");
                break;
            case .beforeSources:
                print("即将处理input Sources");
                break;
            case .beforeWaiting:
                print("即将睡眠");
                break;
            case .afterWaiting:
                print("从睡眠中唤醒，处理完唤醒源之前");
                break;
            case .exit:
                print("退出");
                break;
            default:
                break;
            }
        }
    }
}
//https://blog.ibireme.com/2015/05/18/runloop/
/**
 线程和 RunLoop 之间是一一对应的，其关系是保存在一个全局的 Dictionary 里。线程刚创建时并没有 RunLoop，如果你不主动获取，那它一直都不会有。RunLoop 的创建是发生在第一次获取时，RunLoop 的销毁是发生在线程结束时。你只能在一个线程的内部获取其 RunLoop（主线程除外）。
 */




class RunLoopViewController: BaseViewController {
    
    
    /**
    常住线程
     */

    func getThread() ->Thread{
        let thread = Thread(target: self, selector: #selector(holdThread), object: nil)
        thread.start()
        return thread
    }

    @objc func holdThread(){
        
        
        RunLoop.current.add(NSMachPort(), forMode: .default)
        RunLoop.current.run()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
  

    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
