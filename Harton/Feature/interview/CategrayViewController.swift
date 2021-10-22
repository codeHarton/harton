//
//  CategrayViewController.swift
//  Harton
//
//  Created by harton on 2021/10/20.
//

import UIKit
/**
 1.使用场合
 2.实现原理
 3.category和扩展的区别
 4.category 中的load  何时调用 过程 集成
 5.能否条件成员变量  如何添加
 */


/**
 区别
 1.调用方式 --
 2.调用时刻
 3.调用顺序
 load
 1.先调用类 在调用分类
 a 先编译先调用
 b调用子类之前先调用父类
 
 initialize
 a 先初始化子类
 再子类
 */
class CategrayViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        编译时候生成 category_t结构
//        runtime运行时添加到类对象里面

        
//        最后面编译的分类放在前面
        
//        complie sources可以控制编译顺序
        
//        类扩展主要是私有化
        
//        类扩展编译时候就合并到类对象里面  分类是运行时合并
        
        
//        类的load方法 比category优先执行
        
        
        
//    load    父类 - 子类 - 分类
        
//        initialize类第一次接收到消息时调用
        
        
        
        
        
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
