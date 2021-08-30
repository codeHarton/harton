//
//  RxViewController.swift
//  Harton
//
//  Created by harton on 2021/8/26.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx
import SnapKit
import Moya


class Person: NSObject {
   @objc var name = "value"
}
class RxViewController: BaseViewController {

    lazy var textField = UITextField()
    lazy var button = UIButton()
    let per = Person()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(textField)
        textField.snp.makeConstraints { make  in
            make.center.equalToSuperview()
            make.left.equalTo(44)
            make.height.equalTo(44)
        }
        
        self.view.addSubview(button)
        button.snp.makeConstraints { make  in
            make.centerX.equalToSuperview()
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.left.equalTo(44)
            make.height.equalTo(44)
        }
        button.setTitleColor(.cyan, for: .normal)
        button.setTitle("test", for: .normal)
        textField.placeholder = "你好"
        
        textField.text = "诶"
        textField.rx.text.bind(to: button.rx.title()).disposed(by: rx.disposeBag)
        button.rx.controlEvent(.touchUpInside).throttle(1, scheduler: MainScheduler.instance)._subscribe {
            
    
        }
        button.rx.controlEvent(.touchUpInside)._subscribe(onNext: {self.navigationController?.pushViewController(NetViewController(), animated: true)}).disposed(by: rx.disposeBag)
        
        
        
        
      


        
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
