//
//  PromiseViewController.swift
//  Harton
//
//  Created by harton on 2021/8/31.
//

import UIKit
import PromiseKit
import CocoaLumberjack
import SnapKit
import Aspects
import Kingfisher
import ProgressHUD
import RxSwift
import RxCocoa
import coswift
extension AnimationType : CustomStringConvertible{
    public var description: String{
        switch self {
        case .systemActivityIndicator : return "systemActivityIndicator"
        case .horizontalCirclesPulse : return "horizontalCirclesPulse"
        case .lineScaling : return "lineScaling"
        case .singleCirclePulse : return "singleCirclePulse"
        case .multipleCirclePulse : return "multipleCirclePulse"
        case .singleCircleScaleRipple : return "singleCircleScaleRipple"
        case .multipleCircleScaleRipple : return "multipleCircleScaleRipple"
        case .circleSpinFade : return "circleSpinFade"
        case .lineSpinFade : return "lineSpinFade"
        case .circleRotateChase : return "circleRotateChase"
        case .circleStrokeSpin : return "circleStrokeSpin"
        }
    }
}
class HUDViewController: BaseViewController {
    
    lazy var sema = DispatchSemaphore(value: 1)
    
    lazy var lock = NSLock()
    
    lazy var clock = NSConditionLock(condition: 1)
    
    lazy var tableView = UITableView(frame: .zero,style: .plain)
    
    override func viewDidLoad() {
        ProgressHUD.animationType = .systemActivityIndicator
        ProgressHUD.show()
        URLSession.shared.rx.json(url: URL(string:"https://bizhi.feihuo.com/pc/v/list")!)._subscribe { value in
            ProgressHUD.dismiss()
            print(value)
        }.disposed(by: self.rx.disposeBag)
        
  
        
        super.viewDidLoad()
        ProgressHUD.colorBackground = UIColor.green.withAlphaComponent(0.2)
        ProgressHUD.colorHUD = .yellow
        ProgressHUD.colorAnimation = .red
        ProgressHUD.colorStatus = .cyan
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make  in
            make.edges.equalToSuperview()
        }
        ProgressHUD.colorProgress = .purple
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        Observable<[AnimationType]>.just([.systemActivityIndicator
                                          ,.horizontalCirclesPulse
                                          ,.lineScaling
                                          ,.singleCirclePulse
                                          ,.multipleCirclePulse
                                          ,.singleCircleScaleRipple
                                          ,.multipleCircleScaleRipple
                                          ,.circleSpinFade
                                          ,.lineSpinFade
                                          ,.circleRotateChase
                                          ,.circleStrokeSpin]).bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)){
                                            row, ele, cell in
                                            cell.textLabel?.text = ele.description
                                          }.disposed(by: rx.disposeBag)
        
        
        tableView.rx.modelSelected(AnimationType.self)._subscribe { type in
            ProgressHUD.animationType = type
            ProgressHUD.show(type.description)
//            switch type{
//            case .systemActivityIndicator:
//                ProgressHUD.show("icon: .added")
//            case .horizontalCirclesPulse:
//                ProgressHUD.showSucceed("成功")
//            case .lineScaling:
//                ProgressHUD.showProgress(0.5,interaction: true)
//            case .singleCirclePulse:
//                ProgressHUD.show(type.description)
//            case .multipleCirclePulse:
//                ProgressHUD.show(type.description)
//            case .singleCircleScaleRipple:
//                ProgressHUD.show(type.description)
//            case .multipleCircleScaleRipple:
//                ProgressHUD.show(type.description)
//            case .circleSpinFade:
//                ProgressHUD.show(type.description)
//            case .circleRotateChase:
//                ProgressHUD.show(type.description)
//            case .lineSpinFade:
//                ProgressHUD.showFailed("失败")
//
//            case .circleStrokeSpin:
//                ProgressHUD.showFailed()
//            }
            
            
        }.disposed(by: rx.disposeBag)
        tableView.rx.itemSelected._subscribe {[weak self] index in
            self?.tableView.deselectRow(at: index, animated: true)
        }.disposed(by: rx.disposeBag)
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(rightAciton))
    }
    
    @objc func rightAciton(){
        ProgressHUD.dismiss()
        let aView = UIView()
        self.view.addSubview(aView)
        aView.backgroundColor = .darkGray
        aView.snp.makeConstraints { make  in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        animationHorizontalCirclesPulse(aView)
    }
    
    private func animationHorizontalCirclesPulse(_ sView: UIView) {

        let width : CGFloat = 60
        let height : CGFloat = 60

        let spacing: CGFloat = 3
        let radius: CGFloat = (width - spacing * 2) / 3
        let ypos: CGFloat = (height - radius) / 2

        let beginTime = CACurrentMediaTime()
        let beginTimes = [0.36, 0.24, 0.12]
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)

        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.keyTimes = [0, 0.5, 1]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.values = [1, 0.3, 1]
        animation.duration = 1
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        let path = UIBezierPath(arcCenter: CGPoint(x: radius/2, y: radius/2), radius: radius/2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

        for i in 0..<3 {
            let layer = CAShapeLayer()
            layer.frame = CGRect(x: (radius + spacing) * CGFloat(i), y: ypos, width: radius, height: radius)
            layer.path = path.cgPath
            layer.fillColor = UIColor.cyan.cgColor
            animation.beginTime = beginTime - beginTimes[i]

            layer.add(animation, forKey: "animation")
            sView.layer.addSublayer(layer)
        }
    }
    
    deinit {
        ProgressHUD.dismiss()
    }
    
    func run(){
        
    }
    
    @objc func btnAction(){
        #function.log()
        
        DispatchQueue.global().async {
            //            self.sema.wait()
            self.lock.lock()
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                "count".log()
                //                self.sema.signal()
                self.lock.unlock()
            }
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
