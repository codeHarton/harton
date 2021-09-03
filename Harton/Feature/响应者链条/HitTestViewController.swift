//
//  HitTestViewController.swift
//  Harton
//
//  Created by harton on 2021/9/3.
//

import UIKit
import SwifterSwift

// MARK:2.响应过程
/**
 iOS系统检测到手指触摸(Touch)操作时会将其打包成一个UIEvent对象，并放入当前活动Application的事件队列，单例的UIApplication会从事件队列中取出触摸事件并传递给单例的UIWindow来处理，UIWindow对象首先会使用hitTest:withEvent:方法寻找此次Touch操作初始点所在的视图(View)，即需要将触摸事件传递给其处理的视图(最合适来处理的控件)，这个过程称之为hit-test view。

 那么什么是最适合来处理事件的控件?
 1.自己能响应触摸事件
 2.触摸点在自己身上
 3.从后往前递归遍历子控件, 重复上两步
 4.如果没有符合条件的子控件, 那么就自己最合适处理
 */


/**
 1.事件的传递方向: 事件传递是从上自下传递，响应是从下到上，所谓的上就是父视图而已，也就是离窗口最近的.
 2.穿透控件:
 2.1 如果我们不想让某个视图响应事件，只需要重载 PointInside:withEvent:方法，让此方法返回NO就行了.
 2.2 若是view上有view1，view1上有view2，点击view2，view2自己响应，点击view1，view1不响应，只有view响应，也就是隔层传递
 */
class HitTestViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    override func setupViews() {
        
        let imgView = UIImageView(image: UIImage(named: "hit_test"))
        self.view.addSubview(imgView)
        imgView.snp.makeConstraints { make  in
            make.edges.equalToSuperview()
        }
        imgView.contentMode = .scaleAspectFit
        
        
        let aview = AView()
        aview.text = "A"
        self.view.addSubview(aview)
        aview.snp.makeConstraints { make  in
            make.centerX.equalToSuperview()
            make.top.equalTo(100)
            make.size.equalTo(CGSize(width: 200, height: 200))

        }
        
        let dview = DView()
        dview.text = "D"
        aview.addSubview(dview)
        dview.snp.makeConstraints { make  in
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.top.centerY.equalToSuperview()
            
        }
        
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

class HitView: UILabel {
    
    override var isUserInteractionEnabled: Bool{
        get{
            return true
        }
        set{}
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("===\n",#function,type(of: self).debugDescription())
        guard let view = super.hitTest(point, with: event) else{
            print("view为空")
            return nil
        }
        print(type(of: view).debugDescription(),"\n==")
        return view
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print(#function,type(of: self).debugDescription())
        let value = super.point(inside: point, with: event)
        print("是否在之内",value.description)
        return value
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .random
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AView: HitView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        // MARK:hitTest 伪代码
        guard alpha > 0.01,isUserInteractionEnabled,!isHidden else {
            return nil
        }
        guard self.point(inside: point, with: event) else {
            return nil
        }
//        从后往前遍历每一个子控件
        for view in subviews.reversed(){
            //坐标转换
            let _point = convert(point, to: view)
            if let _v = view.hitTest(_point, with: event) {return _v }
        }
        return self
    }
}

class BView: HitView {
    
}
class CView: HitView {
    
}

class DView: HitView {
    
}
