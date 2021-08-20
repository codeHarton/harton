//
//  SandBoxViewController.swift
//  Harton
//
//  Created by harton on 2021/8/17.
//

import UIKit
/**
 沙盒系统
 Documents:保存应用运行时生成的需要持久化的数据，iTunes会自动备份该目录
 tmp:保存应用运行时所需的临时数据，使用完毕后再将相应的文件从该目录删除，应用没有运行时，系统也可能会自动清理该目录下的文件，iTunes不会同步该目录，iPhone重启时该目录下的文件会丢失。
 Libaray:存储程序的默认设置和其他状态信息，iTunes会自动备份该目录。
 Libaray/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除，一般存放体积比较大，不是很重要的资源
 Libaray/Preferences:保存应用的所有偏好设置，ios的Settings（设置）应用会在该目录中查找应用的设置信息，iTunes会自动备份该目录。
 */
class SandBoxViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    /**
     目录结构
     Documents
     Library
     SystemData
     tmp
     */
    
    override func remarks() {
        //应用程序的沙盒路径
        let homePaht = NSHomeDirectory()
        print(homePaht)
        self.documents().cache().tmp().systemData()
    }
    
    
    /**
     保存持久化数据，会备份。一般用来存储需要持久化的数据。
     一般我们在项目中，我们会把一些用户的登录信息以及搜索历史记录等一些关键数据存储到这里。
     */
    func documents() ->SandBoxViewController{
        guard let documentPaht = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else{
            return self
        }
        print(documentPaht)
        return self
    }
    
    /**
     1.缓存数据应该保存在/Library/Caches目录下.
     2.缓存数据在设备低存储空间时可能会被删除，iTunes或iCloud不会对其进行备份。
     3.可以保存重新下载或生成的数据，而且没有这些数据也不会妨碍用户离线使用应用的功能。
     4.当访问网络时系统自动会把访问的url,以数据库的方式存放在此目录下面.
     */
    func cache()->SandBoxViewController{
        guard let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
            return self
        }
        print(cachePath)
        
        return self
    }
    
    /**
     临时文件夹(系统会不定期删除里面的文件)
     
     // 获取tmp目录路径
     NSString *tmpDir = NSTemporaryDirectory();
     临时数据应该保存在/tmp目录。
     应用需要写到本地存储，内部使用的临时数据，但不需要长期保留使用。
     系统可能会清空该目录下的数据，iTunes或iCloud也不会对其进行备份。
     */
    func tmp()->SandBoxViewController{
        let tmpPath = NSTemporaryDirectory()
        print(tmpPath)
        return self
    }
    
    @discardableResult
    func systemData() ->SandBoxViewController{
        return self
    }
    
}
