//
//  InitViewController.swift
//  Harton
//
//  Created by harton on 2021/9/2.
//

import UIKit

extension Foundation.Timer {
    static func weak_scheduledTimer(interval : TimeInterval,_repeat : Bool = true,block : @escaping (_ timer : Timer) ->Void){
        
        Foundation.Timer.scheduledTimer(timeInterval: interval, target: self, selector:#selector(_timerAction(timer:)), userInfo: block, repeats: _repeat)
    }
    
    @objc static func _timerAction(timer : Foundation.Timer){
        let block = timer.userInfo as? ((_ timer : Foundation.Timer) ->Void)
        block?(timer)
    }
}

class InitViewController: BaseViewController {
    
    // MARK:(4)线程死锁

/**发生线程死锁的条件：
使用 dispatch_sync() 函数往当前 串行队列里面添加任务就会产生死锁。
几个典型的 死锁案例：
    */
    
    
// MARK:常见泄漏
    /**
     1.delegate
     2.block
     3.timer
     4.AFN
     5.大次循环
     */
    
    
    /**
     APP启动全过程
     1:APP启动过程
     解析Info.plist
     加载相关信息，例如闪屏
     沙盒建立、权限检查
     Macch-O加载
     如果二进制文件，寻找合适当前CPU类别的部分
     加载所有依赖的Mach-O文件（递归调用Mach-O加载方法）
     定位内部、外部指针引用，例如字符串，函数等
     执行声明为attribute(constructor)的C函数
     记载类的扩展方法
     *C++静态对象加载，调用Objc的+load函数
     
     
     2:程序执行

     main函数
     执行UIApplicationMain函数
     创建UIApplication对象
     创建UIApplicationDelegate对象并复制
     读取配置文件info.plist,设置程序启动的一些属性
     创建应用程序的Main RunLoop循环
     UIApplicationDelegate对象开始处理监听事件
     程序启动之后，首先调用application.didFinisuncinitOption方法
     如果info.plist中配置了启动的storyBoard的文件名，则加载storyboard文件
     如果没有配置，则根据代码创建UIWindow-->rootViewController显示



     1:第三方框架使用不当
     2:闭包循环引用
     3:delegate的循环引用
     4:大次数循环内存暴涨
     5:计时器的循环引用
     
     
     

     
     
     链接：https://www.jianshu.com/p/b653c5f0b2a7
     来源：简书
     */
    
    // MARK:AFNetworking 内存泄漏
    /**
     AFHTTPSessionManager继承于AFURLSessionManager，AFURLSessionManager有个属性session，session类型是NSURLSession，调用NSURLSession进行请求后，等请求完毕后调用session的finishTasksAndInvalidate方法，或者调用取消session的invalidateAndCancel方法，再或者将session属性置成nil，这样AFURLSessionManager就能正常释放，这样就不需要将AFHTTPSessionManager写成单例来使用了。NSURLSession将代理属性delegate强引用了，所以NSURLSession影响了其delegate的释放，调用其中的一个invalidate方法时，就会将其delegate引用计数减一，这样其delegate就能正常释放了，这里的delegate就是AFURLSessionManager。
     */
    
    
    // MARK:深浅拷贝  http://www.cocoachina.com/articles/17275    https://www.jianshu.com/p/f01d490401f9
    //NSMutableString 用copy 和NSString 用strong的影响
    
    var session : URLSession?

    
    var test : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    ///定时器内存问题 不是循环引用
        
//        定时器即使不被引用，也可以正常运行。控制器可以弱引用定时器，这样就不存在循环引用了。第一种选择只解决了循环引用导致的内存泄漏问题，并不能解决当前控制器无法释放的问题，原因是Runloop对定时源的观察者要进行保留以便时间点到了进行调用，即定时器对象被Runloop强保留着，而定时器对象又强保留着当前控制器。


        //  Timer.scheduledTimer(timeInterval: 5, target:  self, selector: #selector(timerAction), userInfo: nil, repeats: false)
       // Timer.scheduledTimer(timeInterval: 5, target: YYWeakProxy(target: self), selector: #selector(timerAction), userInfo: nil, repeats: false)
        ///这里需要weak处理
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {[weak self] tim in
//            print(#function,self?.description)
//        }
        
        
//        Timer.weak_scheduledTimer(interval: 1) { timer in
//         print("info")
//        }
//        displayLink()

        //dispatch_source()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(rightAciton))
        
        setupSession()
    }
    
    

    func setupSession(){
        let url = URL(string:"https://bizhi.feihuo.com/pc/v/list")!
//        session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
//        let task =  session?.dataTask(with:url )
//        task?.resume()
//
        
        // MARK:此处如果没有resume会造成内存泄漏
        URLSession.shared.dataTask(with: url) { data, response , error in
            print(data?.count,self.description)
        }.resume()
    }
    
    
    
    @objc func rightAciton(){
        guard let lin = link else {
            return
        }
        lin.isPaused = !lin.isPaused
    }
    
    var source_timer : DispatchSourceTimer?
    
    func dispatch_source(){
        source_timer = DispatchSource.makeTimerSource()
        source_timer?.schedule(deadline: .now(), repeating: 1)
        source_timer?.setEventHandler(handler: {
            
        })
        source_timer?.resume()
        source_timer?.cancel()
        source_timer?.suspend()
    }
    
    var link : CADisplayLink?
    
    
    func displayLink(){
        link = CADisplayLink(target: YYWeakProxy(target: self), selector: #selector(timerAction))
        link?.add(to: .current, forMode: .default)
        link?.frameInterval
    }
    
    
    
    @objc func timerAction(){
        print(#function)
    }
    
    deinit {
        link?.invalidate()
        link = nil
       // timer?.invalidate()
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

extension InitViewController : URLSessionTaskDelegate,URLSessionDataDelegate{
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void){
        print(response.debugDescription)
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        ///
        print("收到数据 = \(data.count)")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("请求完成")
        session.finishTasksAndInvalidate()
        
    }
}

