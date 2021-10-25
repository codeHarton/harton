//
//  RuntimeViewController.swift
//  Harton
//
//  Created by harton on 2021/10/23.
//

import UIKit

/**
 1.消息机制
 2.消息转发机制流程
 3.什么是runtime,平时项目中有用过吗
 
   - 1.关联对象 (分类添加属性)
   - 2.遍历类的所有成员变量(可以访问私有成员变量 ,修改tefield占位,字典转模型,自动归档,解档)
 4.@synthesize和@dynamic
 
 
 
 
 
 
 栈空间从大到小分配
 
 super 本质
 栈空间
 消息机制
 访问成员变量本质
 */

//c语言函数名就是函数地址
extension Bool{
    func log(){
        print(self)
    }
}
class RuntimeViewController: BaseViewController {
    
    struct Union{
     
    }
    

    let tall = 1<<0
    let rich = 1<<1
    let handsme = 1<<2
    
    var tallRichHandsome = 0b0000000000000110
    override func viewDidLoad() {
        super.viewDidLoad()

        isRich().log()
        isHandsme().log()
        isTall().log()
        // Do any additional setup after loading the view.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.setRich(rich: false)
        self.setTall(tall: false)
        self.setHandSome(handsme: false)
        
        
        
        isRich().log()
        isHandsme().log()
        isTall().log()
    }
    
    func isRich() ->Bool{
        return ((tallRichHandsome & rich) != 0)
    }
    
    func isTall() ->Bool{
        return ((tallRichHandsome & tall) != 0)
    }

    func isHandsme() ->Bool{
        return ((tallRichHandsome & handsme) != 0)
    }
    
    
    func setRich(rich : Bool){
        if rich{
            self.tallRichHandsome |= self.rich
        }else{
            self.tallRichHandsome &= ~self.rich
        }
    }
    
    func setTall(tall : Bool){
        if tall{
            self.tallRichHandsome |= self.tall
        }else{
            self.tallRichHandsome &= ~self.tall
        }
    }
    
    func setHandSome(handsme : Bool){
        if handsme{
            self.tallRichHandsome |= self.handsme
        }else{
            self.tallRichHandsome &= ~self.handsme
        }    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
