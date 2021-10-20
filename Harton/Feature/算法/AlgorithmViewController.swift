//
//  AlgorithmViewController.swift
//  Harton
//
//  Created by harton on 2021/10/19.
//

import UIKit

class AlgorithmViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.rank(value: [1,23,4,25,100,-1,34,5,234,3,4,5,10,50,2,6]).log()
    }
    
    func rank(value : [Int]) ->[Int]{
        
        var tmp = value
        for i in 0..<tmp.count{
            for j in 0..<tmp.count - i - 1{
                if tmp[j] > tmp[j + 1] {
                    let tmpValue = tmp[j+1]
                    tmp[j + 1] = tmp[j]
                    tmp[j] = tmpValue
                }
            }
        }
        return tmp
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
