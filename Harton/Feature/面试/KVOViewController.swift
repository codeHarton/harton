//
//  KVOViewController.swift
//  Harton
//
//  Created by harton on 2021/10/19.
//

import UIKit

/**
 问
 1.kvo原理  本质是set方法
 2.如何手动触发
 3.直接修改成员变量会触发吗
 4.通过kvc修改属性 会不会触发kvo
 5.kvc的赋值和取值过程 原理
 */
//        NSKVONotifying_Persion类
        
//        实现的方法
        

        /**
         setAge
         class
         dealloc
         _isKVO
          
         
         设置值
         setAge _setAge
         _age _isAge age isAge
         
         取值
         getKey key isKey _key
         */

///手动触发kvo
///手动调用 will 和did
///
///
    /**
     
     override class func willChangeValue(forKey key: String) {
         
     }
     override class func didChangeValue(forKey key: String) {
         
     }
     
     */

class KVOStudent : NSObject{
    var age : Int = 0
}
class KVOViewController: BaseViewController {

    
    
   
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
