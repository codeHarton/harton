//
//  LoginButton.swift
//  Harton
//
//  Created by harton on 2021/9/8.
//

import UIKit

class LoginButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _initViews()
    }
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _initViews()
    }
    
    
    private func _initViews(){
        cornerRadius = .cornerRadius
        setBackgroundColor(.disButtonColor, for: .disabled)
        setBackgroundColor(.normalButtonColor, for: .normal)
        setTitleColor(.white, for: .normal)
    }
}
