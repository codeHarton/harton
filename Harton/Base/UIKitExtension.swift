//
//  UIKitExtension.swift
//  Harton
//
//  Created by harton on 2021/10/20.
//

import Foundation

extension UIEdgeInsets{
    static func all(_ value : CGFloat) -> UIEdgeInsets{
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    static func only(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) ->UIEdgeInsets{
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    static func left(_ value : CGFloat) ->UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: value, bottom: 0, right: 0)
    }
    
    static func right(_ value : CGFloat) ->UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: value)
    }
    
    static func bottom(_ value : CGFloat) ->UIEdgeInsets{
        return UIEdgeInsets(top: value, left: 0, bottom: 0, right: 0)
    }
    
    static func top(_ value : CGFloat) ->UIEdgeInsets{
        return UIEdgeInsets(top: value, left: 0, bottom: 0, right: 0)
    }
    
}
