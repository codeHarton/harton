//
//  SandBoxViewController.swift
//  Harton
//
//  Created by harton on 2021/8/17.
//

import UIKit
/**
 沙盒系统
 iOS中的沙盒机制是一种安全体系。为了保证系统安全，iOS每个应用程序在安装时，会创建属于自己的沙盒文件（存储空间）。应用程序只能访问自身的沙盒文件，不能访问其他应用程序的沙盒文件，当应用程序需要向外部请求或接收数据时，都需要经过权限认证，否则，无法获取到数据。所有的非代码文件都要保存在此，例如属性文件plist、文本文件、图像、图标、媒体资源等，其原理是通过重定向技术，把程序生成和修改的文件定向到自身文件夹中。
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
