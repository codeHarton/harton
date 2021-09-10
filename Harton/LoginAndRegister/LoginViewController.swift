//
//  LoginViewController.swift
//  Harton
//
//  Created by harton on 2021/9/7.
//

import UIKit
import RxSwift
class LoginViewController: BaseViewController {
    @IBOutlet weak var phoneTf : RegisterTextField!
    
    @IBOutlet weak var passwordTf : RegisterTextField!
    
    @IBOutlet weak var loginBtn : LoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneTf.valueType = .phone
        passwordTf.valueType = .password
        
        _bind()
        // Do any additional setup after loading the view.
    }
    
    private func _bind(){
        Observable.combineLatest(phoneTf.rx.text.orEmpty.skip(1).map{$0.count == 11},passwordTf.rx.text.orEmpty.skip(1).map{$0.count >= 6}){$0 && $1}.bind(to: loginBtn.rx.isEnabled).disposed(by: rx.disposeBag)
    }
    
    @IBAction func back(sender : Any){
        
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phoneTf._resgin()
        passwordTf._resgin()
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
