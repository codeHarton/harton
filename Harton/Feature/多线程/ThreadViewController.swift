//
//  ThreadViewController.swift
//  Harton
//
//  Created by harton on 2021/9/2.
//

import UIKit

class ThreadViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        sisuo()
        concurrent_async()
        // Do any additional setup after loading the view.
    }
    
    /**
     在主队列中添加同步任务造成死锁就是主线程和主队列的互相等待。
     主队列中的任务一定是在主线程中执行的，但主线程可执行非主队列的队列上的任务。

     异步执行有开启新线程的能力， 但有这种能力并不一定会利用这种能力。
     线程不会无限开启。
     异步任务+串行队列：无论有多少个异步任务，开启的线程也只有一个。在新线程中的所有任务也都是串行执行的。

     系统会把主队列中的任务放到主线程中。

     异步任务+主队列并不会开启新的线程。主线程中执行任务。

     作者：梁森的简书
     链接：https://www.jianshu.com/p/546493892cca
     来源：简书
     著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
     */
    
    // MARK:死锁
    
    func sisuo(){
        let queue = DispatchQueue(label: "s")
        queue.async {
            print("----")
            queue.sync {
                ///死锁
                print("----")
            }
        }
    }
    
    // MARK:串行队列＋同步任务是串行执行，且没有开启子线程
    
    func serial_sync(){
        let queue = DispatchQueue(label: "s")
        queue.sync {
            for i in 0..<10{
                print("1-------\(i),therad = \(Thread.current)")
            }
        }
        queue.sync {
            for i in 0..<10{
                print("2-------\(i),therad = \(Thread.current)")
            }
        }
        queue.sync {
            for i in 0..<10{
                print("3-------\(i),therad = \(Thread.current)")
            }
        }
    }
    
    // MARK:串行队列＋异步任务是串行执行，且只开启了一个子线程。
    func serial_async(){
        let queue = DispatchQueue(label: "s")
        queue.async {
            for i in 0..<10{
                print("1-------\(i),therad = \(Thread.current)")
            }
        }
        queue.async {
            for i in 0..<10{
                print("2-------\(i),therad = \(Thread.current)")
            }
        }
        queue.async {
            for i in 0..<10{
                print("3-------\(i),therad = \(Thread.current)")
            }
        }
    }
    
    
    // MARK:并发队列＋同步任务是串行执行，且没有开启子线程
    
    func concurrent_sync(){
        let queue = DispatchQueue(label: "s",attributes: .concurrent)
        queue.sync {
            for i in 0..<10{
                print("1-------\(i),therad = \(Thread.current)")
            }
        }
        queue.sync {
            for i in 0..<10{
                print("2-------\(i),therad = \(Thread.current)")
            }
        }
        queue.sync {
            for i in 0..<10{
                print("3-------\(i),therad = \(Thread.current)")
            }
        }
    }
    
    
    // MARK:并发队列＋异步任务是并发执行，且开启了多个子线程。
    
    func concurrent_async(){
        let queue = DispatchQueue(label: "s",attributes: .concurrent)
        queue.async {
            for i in 0..<10{
                print("1-------\(i),therad = \(Thread.current)")
            }
        }
        queue.async {
            for i in 0..<10{
                print("2-------\(i),therad = \(Thread.current)")
            }
        }
        queue.async {
            for i in 0..<10{
                print("3-------\(i),therad = \(Thread.current)")
            }
        }
    }
    
}
