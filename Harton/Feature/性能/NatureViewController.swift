//
//  NatureViewController.swift
//  Harton
//
//  Created by harton on 2021/10/11.
//

import UIKit
import YYCategories
extension UIImage {
    func kt_drawRectWithRoundedCorner(radius: CGFloat, _ sizetoFit: CGSize) -> UIImage? {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: sizetoFit)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.addPath(UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.allCorners,
                                     cornerRadii: CGSize(width: radius, height: radius)).cgPath)
        context.clip()
        self.draw(in: rect)
        context.drawPath(using: .fillStroke)
        let output = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return output
    }
}

class NatureViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView()
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { make  in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 64, height: 64))
        }
        let image = UIImage(named: "wechat")
//        imageView.image = image?.kt_drawRectWithRoundedCorner(radius: 30, CGSize(width: 64, height: 64))
        imageView.image = image?.byRoundCornerRadius(30)
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

/**
 
 https://blog.csdn.net/u011774517/article/details/56013365
 
 https://blog.csdn.net/myinclude/article/details/84933184
 ivar、getter、setter 是如何生成并添加到这个类中的?
 完成属性定义后，编译器会自动编写访问这些属性所需的方法，此过程叫做“自动合成”(autosynthesis)。需要强调的是，这个过程由编译 器在编译期执行，所以编辑器里看不到这些“合成方法”(synthesized method)的源代码。除了生成方法代码 getter、setter 之外，编译器还要自动向类中添加适当类型的实例变量，并且在属性名前面加下划线，以此作为实例变量的名字。在前例中，会生成两个实例变量，其名称分别为 _firstName 与 _lastName。也可以在类的实现代码里通过 @synthesize 语法来指定实例变量的名字.

 
 
 默认使用了@synthesize ,默认给变量添加一个前缀。
 如果使用了@dynamic ,则需要自己实现setter, getter方法，Runtime
 
 
 在协议@protocol中使用@property只会生成setter和getter方法声明，我们使用属性的目的就是希望遵守我们协议的对象能够实现该属性；
 
 assign 可以用非 OC 对象,而 weak 必须用于 OC 对象

 */


/**
 野指针
 https://www.jianshu.com/p/8aba0ee41cd7
 
 
 内存是否被覆盖
 
 被覆盖就有崩溃危险
 
 uilabel ->uibutton
 
 */
