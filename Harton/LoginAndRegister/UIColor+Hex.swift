//
//  UIColor+Hex.swift
//  Harton
//
//  Created by harton on 2021/9/8.
//

import Foundation


extension UIColor{
    ///  #333333
    static var color_333 : UIColor?{
        return UIColor(hexString: "#333333")
    }
    
    ///  #666666
    static var color_666 : UIColor?{
        return UIColor(hexString: "#666666")
    }
    
    /// 按钮不可用颜色   #D4D8DC
    static var disButtonColor : UIColor{
        return UIColor(hexString: "#D4D8DC") ?? .lightGray
    }
    
    /// 按钮可以颜色   #122F49
    static var normalButtonColor : UIColor{
        return UIColor(hexString: "#122F49") ?? .black
    }
    
}
