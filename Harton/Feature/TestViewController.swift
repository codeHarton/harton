//
//  TestViewController.swift
//  Harton
//
//  Created by harton on 2021/10/12.
//

import UIKit

class ManPerson: NSObject{
    var name : String = ""
}
class TestViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let queue = DispatchQueue(label: "lock_d")
        queue.async {
            queue.async {
                print("value")
            }
        }
       
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
