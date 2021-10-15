//
//  LockViewController.swift
//  Harton
//
//  Created by harton on 2021/8/31.
//

import UIKit

///https://tianxueweii.github.io/2018/11/26/%E5%85%B3%E4%BA%8EiOS%E7%BA%BF%E7%A8%8B%E9%94%81%E7%9A%84%E4%B8%80%E7%82%B9%E7%A0%94%E7%A9%B6/

class LockViewController: BaseViewController {

    /**
     自旋锁会忙等: 所谓忙等，即在访问被锁资源时，调用者线程不会休眠，而是不停循环在那里，直到被锁资源释放锁。
     　　互斥锁会休眠: 所谓休眠，即在访问被锁资源时，调用者线程会休眠，此时cpu可以调度其他线程工作。直到被锁资源释放锁。此时会唤醒休眠线程。

     优缺点：
     　　自旋锁的优点在于，因为自旋锁不会引起调用者睡眠，所以不会进行线程调度，cpu时间片轮转等耗时操作。所有如果能在很短的时间内获得锁，自旋锁的效率远高于互斥锁。
     　　缺点在于，自旋锁一直占用CPU，他在未获得锁的情况下，一直运行－－自旋，所以占用着CPU，如果不能在很短的时 间内获得锁，这无疑会使CPU效率降低。自旋锁不能实现递归调用。

     */
    
    lazy var queue = DispatchQueue(label: "---",attributes: .concurrent)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        ques3()
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
    
    func test(){
        let queue = DispatchQueue(label: "1", qos: .background)
        queue.async {
            Thread.threadPriority().log(prefix: "background")
            Thread.current.log()
        }
        
        let queue2 = DispatchQueue(label: "2", qos: .utility)
        queue2.async {
            Thread.threadPriority().log(prefix: "utility")
            Thread.current.log()
        }
        
        let queue3 = DispatchQueue(label: "3", qos: .default)
        queue3.async {
            Thread.threadPriority().log(prefix: "default")
            Thread.current.log()
        }
        
        let queue4 = DispatchQueue(label: "4", qos: .userInitiated)
        queue4.async {
            Thread.threadPriority().log(prefix: "userInitiated")
            Thread.current.log()
        }
        
        let queue5 = DispatchQueue(label: "5", qos: .userInteractive)
        queue5.async {
            Thread.threadPriority().log(prefix: "userInteractive")
            Thread.current.log()
        }
        
        
    }

}


class Mynavigation: UINavigationController , UINavigationControllerDelegate{
    
}
