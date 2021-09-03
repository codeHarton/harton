//
//  RunLoopViewController.swift
//  Harton
//
//  Created by harton on 2021/9/3.
//

import UIKit

class RunManager {
    static func setup(){
        DispatchQueue.global().async {
            self._setup()
        }
    }
    
    static func _setup(){
        CFRunLoopObserverCreateWithHandler(nil, CFRunLoopActivity.allActivities.rawValue, true, 0) { obser , activi  in
            switch activi{
            case .entry:
                print("即将进入runloop");
                break;
            case .beforeTimers:
                print("即将处理timer");
                break;
            case .beforeSources:
                print("即将处理input Sources");
                break;
            case .beforeWaiting:
                print("即将睡眠");
                break;
            case .afterWaiting:
                print("从睡眠中唤醒，处理完唤醒源之前");
                break;
            case .exit:
                print("退出");
                break;
            default:
                break;
            }
        }
    }
}

class RunLoopViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
