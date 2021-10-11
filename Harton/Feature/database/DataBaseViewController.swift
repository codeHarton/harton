//
//  DataBaseViewController.swift
//  Harton
//
//  Created by harton on 2021/8/17.
//

import UIKit
import FMDB
class DataBaseViewController: BaseViewController {
/**
     fmdb数据升级
     https://blog.csdn.net/chenyong05314/article/details/80085272
     
     
     NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ text",@"person",@"age"];//这是给一张名为人的表增加一个age字段
     [self.db executeUpdate:sql];

     //设值
     [self.db executeUpdate:[NSString stringWithFormat:@"UPDATE person set age = %@",@"18"]];

     

     */
    override func viewDidLoad() {
        super.viewDidLoad()

        let db = FMDatabase(path: "")
        
        if !db.columnExists("", inTableWithName: "") {
        
            try? db.executeUpdate("ALTER TABLE %@ ADD %@ INTEGER", values: [])
            
        }

        // Do any additional setup after loading the view.
    }
    
    override func remarks() {
        
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
