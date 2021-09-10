//
//  RegisterTextField.swift
//  Harton
//
//  Created by harton on 2021/9/7.
//

import Foundation
import SnapKit

enum TextFeildType {
    case phone
    case password
    
    var placeholder : String{
        switch self {
        case .phone:
            return "请输入入职时使用的手机号"
        default:
            return "请输入密码"
        }
    }
    
    var keyBoardType : UIKeyboardType{
        switch self {
        case .phone:
            return .numberPad
        default:
            return .default
        }
    }
    
    
    var isSecureTextEntry : Bool{
        switch self {
        case .password:
            return true
        default:
            return false
        }
    }
}

class RegisterTextField: UITextField {
    
    lazy var seeBtn : UIButton = {
        let see = UIButton(type: .custom)
        addSubview(see)
        see.snp.makeConstraints { make  in
            make.centerY.equalToSuperview()
            make.right.equalTo(-15)
        }
        see.addTarget(self , action: #selector(_seeAction), for: .touchUpInside)
        return see
    }()
    
    @objc private func _seeAction(sender : UIButton){
        sender.isSelected = !sender.isSelected
        isSecureTextEntry = !sender.isSelected
    }
    
    lazy var tipLabel : UILabel = {
       let label = UILabel()
        label.textColor = UIColor(hexString: "#666666")
        label.font = .boldSystemFont(ofSize: 14)
        addSubview(label)
        label.snp.makeConstraints { make  in
            make.left.equalToSuperview()
            make.bottom.equalTo(snp.top).offset(-20)
        }
        return label
    }()
    
    @IBInspectable var tip : String?
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard valueType == .password,seeBtn.frame.contains(point) else {
            return super.hitTest(point, with: event)
        }
        return seeBtn
    }
    
    var valueType : TextFeildType = .phone{
        didSet{
            self.placeholder = valueType.placeholder
            self.keyboardType = valueType.keyBoardType
            self.isSecureTextEntry = valueType.isSecureTextEntry
            
            if valueType == .password {
                seeBtn.isHidden = false
            }
        }
    }
    
    @discardableResult
    func _resgin() ->Bool{
        if isFirstResponder {
           return resignFirstResponder()
        }
        return false
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _initViews()
    }
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        _initViews()
    }
    
    
    private func _initViews(){
        layer.cornerRadius = 6
        if let tip = tip {
            self.tipLabel.text = tip
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        defer{resetBoardState()}
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        defer{resetBoardState()}
        return super.resignFirstResponder()
    }
    
    private func resetBoardState(){
        layer.borderWidth = isFirstResponder ? 2 : 1
        layer.borderColor = getBoardColor()
        
    }
    
    private func getBoardColor() ->CGColor{
        if isFirstResponder {
            return UIColor.cyan.cgColor
        }
        return UIColor.lightGray.cgColor
    }
}

