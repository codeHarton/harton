//
//  AutoreleasePoolViewController.swift
//  Harton
//
//  Created by harton on 2021/10/12.
//

import UIKit

//https://www.jianshu.com/p/b75a99892261

//https://tianxueweii.github.io/2019/01/13/%E5%85%B3%E4%BA%8EAutoReleasePool%E5%92%8CARC%E7%9A%84%E4%B8%80%E4%BA%9B%E7%A0%94%E7%A9%B6/
/**
 最常出现大量变量的时候显然是循环/遍历, 我们常用的for循环, 以及enumerate其实跟autoreleasepool也有关, for循环是不自动创建autoreleasepool的, 而enumerate中已经自动创建了autoreleasepool, 值得注意的是高并发enumerate常常会出一些意外的问题, 例如对象被提前释放, 所以建议高并发情况下使用for循环(性能高于enumerate), 再手动添加autoreleasepool.



 */
class AutoreleasePoolViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        autoreleasepool {
            for i in 0..<100000{
                
                let obj = NSObject()
            }
        }
    
        

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
