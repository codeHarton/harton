//
//  BlockViewController.swift
//  Harton
//
//  Created by harton on 2021/10/21.
//

import UIKit
/**
1. block的本质是什么
 2. __block的作用是什么,有什么注意
 3.block的属性用什么修饰  使用block有哪些注意
 4.block在修改NSMutableArray  需不需要添加__Block
 5.捕获机制
 6.哪些情况会copy到堆上

 block的类型
 */


/**
 类型
 1. global 没有访问自动变量
 2.stack 访问了自动变量
 */





/**
 内存分配  内存从低到高
1  程序区   (代码)
 2 数据区 .data (全局变量)
 3堆 (malloc  生成的对象)
 4 栈 (局部变量)
 */



/**
 
   1.本质也是oc对象,内部有isa指针
   2.block是封装了函数调用及函数调用环境的oc对象
 
 
 
  **/
class BlockViewController: BaseViewController {

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
