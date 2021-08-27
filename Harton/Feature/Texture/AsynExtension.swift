//
//  AsynExtension.swift
//  Harton
//
//  Created by harton on 2021/8/23.
//

import Foundation
import AsyncDisplayKit


extension ASTextNode{
    public var text : String?{
        get{
            return attributedText?.string
        }
        set{
            guard let value = newValue else {
                return
            }
            self.setText(value)
        }
    }
    
    public func setText(_ text : String?,color : UIColor = .white,fontSize : CGFloat = 17){
        guard let _text = text else {
            attributedText = nil
            return
        }
        attributedText = NSAttributedString(string: _text,attributes: [NSAttributedString.Key.foregroundColor : color,NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize)])
    }
}
