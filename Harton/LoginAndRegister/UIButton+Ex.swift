//
//  UIButton+Ex.swift
//  Harton
//
//  Created by harton on 2021/9/8.
//

import Foundation


extension UIButton {
    
    public func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let img = imageWithColor(color)
        setBackgroundImage(img, for: state)
    }
    
    private func imageWithColor(_ color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
