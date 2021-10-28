//
//  InterviewViewController.swift
//  Harton
//
//  Created by harton on 2021/10/17.
//

import UIKit
/**
 
 代码区：存放程序的代码，即CPU执行的机器指令，并且是只读的。

 常量区：存放常量

 全局区（静态区）：静态变量和全局变量都在这里存储，一旦静态区的内存被分配，静态区的内存直到程序结束才会释放。

 堆区：给程序员用malloc()申请的，然后用free（）释放内存，若申请了堆区内存，忘了释放，容易造成内存泄露。

 栈区：存放函数内的局部变量、行参和函数返回值。栈区中的数据范围过了之后，系统会自动回收栈区的内存，不需要开发人员来动手。栈区就像是一家客栈，里面有很多房间，客人来了之后自动分配房间，房间里的客人可以变动，是一种动态的数据变动。
 */


/**
 
 1.一个NSObject对象占多少内存
 
 系统分配16个字节 给NSObject对象  通过malloc_size获取
 内部只是用8个字节(64位环境)  class_getInstanceSize
 */


//ios对象 占用内存都是16倍数

///实例对象 主要存储成员变量
///类对象存储 1, isa  ,superclass  属性信息@property  对象方法信息 (instancemethod )   协议protocol  成员变量新

//class 方法返回的是类对象

//[NSObject class] 和 object_getClass区别  和objc_getClass

/**
 结构体的大小必须是最大成员变量的倍数
 */

//swift里面 int 8个字节
///int  float 4个字节
/// The native type used to store the CGFloat, which is Float on
/// 32-bit architectures and Double on 64-bit architectures.
class _Student : NSObject{
    let age = 0
    let name = ""
    
    let n : NSInteger = 0
}

struct __Student{
    
}
class InterviewViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let obj = NSObject()
//        obj指向的内存空间占多大内存
        
        
        
        //模拟器(i386)   32bit(armv7)   64bit(arm64)
        
//        一个指针在64位占8字节 32位4字节
        
//        结构体的地址值是第一个成员变量的地址值
        
//        获取NSObject实例对象的成员变量所占用的大小
        let size = class_getInstanceSize(obj as! AnyClass)
    
        
        class_isMetaClass(NSObject.self)
//        oc对象最新16字节
        //malloc_size(obj)
        
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
