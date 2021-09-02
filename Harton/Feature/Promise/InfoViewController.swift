//
//  InfoViewController.swift
//  Harton
//
//  Created by harton on 2021/9/2.
//

import UIKit
import RxAlamofire
import Alamofire
import RxKeyboard
class InfoViewController: BaseViewController {

    let info : Info
    init(info : Info) {
        self.info = info
        super.init(nibName: nil, bundle: nil)
        self.title = info.worksName

    }
    
    lazy var imgView = UIImageView()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgView.kf.setImage(with: URL(string: info.coverUrl_original ?? ""))
        
      
        RxKeyboard.instance.frame.filter({$0.height > 0}).distinctUntilChanged().asObservable()._subscribe { rect in
            print(rect.debugDescription)
          //  UIView.animate(withDuration: 0.25) {
                self.textField.snp.updateConstraints { make in
                    
                    var bottom = -(self.view.bounds.height - rect.minY)
                    if rect.minY == UIScreen.main.bounds.height{bottom = -34}
                    make.bottom.equalTo(bottom)
                }
           // }
            self.view.layoutIfNeeded()

        }.disposed(by: rx.disposeBag)
        
        
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }else{
            textField.becomeFirstResponder()
        }
    }
    override func setupViews() {
        self.view.addSubview(imgView)
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.snp.makeConstraints { make  in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(imgView.snp.width)
        }
        
        self.view.addSubview(textField)
        textField.borderStyle = .roundedRect
        textField.snp.makeConstraints { make  in
            make.centerX.equalToSuperview()
            make.left.equalTo(20)
            make.bottom.equalTo(-34)
            make.height.equalTo(44)
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
