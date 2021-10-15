//
//  NatureViewController.swift
//  Harton
//
//  Created by harton on 2021/10/11.
//

import UIKit
import Moya
import YYCategories
// MARK:离屏渲染  https://www.jianshu.com/p/2bd51fd0016a
/**
 On-Screen Rendering：当前屏幕渲染，在当前用于显示的屏幕缓冲区进行渲染操作
 Off-Screen Rendering：离屏渲染，在当前屏幕缓冲区以外新开辟一个缓冲区进行渲染操作
 离屏渲染消耗性能的原因

 需要创建新的缓冲区
 离屏渲染的整个过程，需要多次切换上下文环境，先是从当前屏幕（On-Screen）切换到离屏（Off-Screen）；等到离屏渲染结束以后，将离屏缓冲区的渲染结果显示到屏幕上，又需要将上下文环境从离屏切换到当前屏幕
 哪些操作会触发离屏渲染？

 光栅化，layer.shouldRasterize = YES
 遮罩，layer.mask
 圆角，同时设置 layer.masksToBounds = YES、layer.cornerRadius大于0
 考虑通过 CoreGraphics 绘制裁剪圆角，或者叫美工提供圆角图片
 阴影，layer.shadowXXX，如果设置了 layer.shadowPath 就不会产生离屏渲染
 
 
 
 
 
 要彻底理解光栅化，还要理解iOS中界面的渲染过程。渲染是一个复杂的过程，要想说明白需要大量篇幅，我们这里长话短说：

 首先CPU计算要显示的内容（包括创建视图，布局计算，图片解码等），得到图层树，然后将图层树通过一系列计算转成渲染树，渲染树的信息会提交给GPU。GPU通过6个阶段的工作后，将CPU和GPU计算后的数据显示在屏幕的每个像素点上。
 




 */

// MARK:光栅化详解  https://www.jianshu.com/p/ce73e3836730?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
/**
 光栅化有什么好处?

 shouldRasterize = YES在其他属性触发离屏渲染的同时，会将光栅化后的内容缓存起来，如果对应的layer及其sublayers没有发生改变，在下一帧的时候可以直接复用。shouldRasterize = YES，这将隐式的创建一个位图，各种阴影遮罩等效果也会保存到位图中并缓存起来，从而减少渲染的频度（不是矢量图）。

 举个栗子

 如果在滚动tableView时，每次都执行圆角设置，肯定会阻塞UI，设置这个将会使滑动更加流畅。
 当shouldRasterize设成true时，layer被渲染成一个bitmap，并缓存起来，等下次使用时不会再重新去渲染了。实现圆角本身就是在做颜色混合（blending），如果每次页面出来时都blending，消耗太大，这时shouldRasterize = yes，下次就只是简单的从渲染引擎的cache里读取那张bitmap，节约系统资源。

 而光栅化会导致离屏渲染，影响图像性能，那么光栅化是否有助于优化性能，就取决于光栅化创建的位图缓存是否被有效复用，而减少渲染的频度。可以使用Instruments进行检测：

 当你使用光栅化时，你可以开启“Color Hits Green and Misses Red”来检查该场景下光栅化操作是否是一个好的选择。
 如果光栅化的图层是绿色，就表示这些缓存被复用；如果是红色就表示缓存会被重复创建，这就表示该处存在性能问题了。

 注意：
 对于经常变动的内容,这个时候不要开启,否则会造成性能的浪费

 作者：路漫漫其修远兮Wzt
 链接：https://www.jianshu.com/p/ce73e3836730
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */


/**
 UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale)，
 第一个参数是想要渲染的图片的尺寸;
 第二个参数用来指定所生成图片的背景是否为不透明，指定为YES得到的图片背景将会是黑色，反之NO表示是透明的;
 第三个参数表示位图的缩放比例，如果设置为 0，表示让图片的缩放因子根据屏幕的分辨率而变化。和 [UIScreen mainScreen].scale相等的。

 作者：村里竹竿
 链接：https://www.jianshu.com/p/34df6a5d0eab
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */

// MARK:高效添加圆角
/// https://www.jianshu.com/p/d568a7e078e9
extension UIImage{
    func circle(radiu : CGFloat = .cornerRadius,size : CGSize) ->UIImage{
        guard !size.equalTo(.zero),radiu > 0 else {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            return self
        }
        let rect = CGRect(origin: .zero, size: size)
        
//        let fillPath = UIBezierPath(ovalIn: rect)
//        UIColor.cyan.setFill()
//        fillPath.fill()
        
     

        let path = UIBezierPath(ovalIn: rect.insetBy(dx: 2, dy: 2))
        path.addClip()

        context.addPath(path.cgPath)
        self.draw(in: rect)

  
        let boardPath = UIBezierPath(ovalIn: rect.insetBy(dx: 3, dy: 3))
        boardPath.close()
        boardPath.lineWidth = 3;
        boardPath.lineJoinStyle = .round;
        UIColor.red.setStroke()
        boardPath.stroke()
        

        
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            return image
        }
        return self
    }
}








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
        imageView.snp.makeConstraints({$0.edges.equalToSuperview()})
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true 
        APIProvider.rx.request(MultiTarget(HartonService.getList(params: ["page":1]))).mapObject(type: ResponseData<ListModel>.self).subscribe { model in
            guard let data = model.data?.info?.first?.coverUrl else{
                return
            }
            imageView.kf.setImage(with: URL(string: data)!)
        } onError: { error  in
            
        }.disposed(by: rx.disposeBag)

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
