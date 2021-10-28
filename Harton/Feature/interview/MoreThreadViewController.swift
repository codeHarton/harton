//
//  MoreThreadViewController.swift
//  Harton
//
//  Created by harton on 2021/10/27.
//

import UIKit
/**
 1.你理解的多线程
 2.ios多线程方案,你倾向哪一种
 3.GCD
 4.gcd的队列类型
 5.operation和gcd去区别优势
 6.线程安全的处理手段
 7.oc你了解锁有哪些
   --1.自旋锁和互斥锁对比
 --2.使用以上锁有哪些注意
 --3.使用c  oc  c++实现自选或互斥锁 口述即可
 
 
 
 
 同步异步并发串行
 
 
 同步 异步 决定能不能开启线程
 
 串行和并发  任务的执行方式
 
 
 递归锁 - 同一个线程多次加锁
 
 */



/**
 线程同步
 1.osspinlock
 2.os_unfair_lock
 3.pthread_mutex
 5.dispatch_semaphore
 6.dispatch_queue
 7.nslock
 8.nsrecursivelock
 9.nscondication
 10.nscondicationlock
 11.@synchronized
 */
class MoreThreadViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let queue = DispatchQueue.global()
        queue.async {
            RunLoop.current.add(Port(), forMode: .default)
                       RunLoop.current.run()
        }
        
        let lock = NSLock()
   
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.run()
    }

    @objc func test(){
        print("2")
    }
    
    func run(){
        let queue = DispatchQueue.global()
        queue.async {
            print("1")
            self.perform(#selector(self.test), afterDelay: 0)
            print("3")
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

}
