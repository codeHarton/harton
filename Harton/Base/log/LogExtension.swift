//
//  LogExtension.swift
//  Harton
//
//  Created by harton on 2021/8/27.
//


protocol Log {
    func log()
    
    func log(prefix : String?)
}


extension Int : Log{}



extension Double : Log{}


extension NSObject : Log{
    func log() {
        print(debugDescription)
    }
    
    
}

extension Dictionary : Log{
    func log() {
        print(debugDescription)
    }
}

extension Error {
    func log(){
        print(localizedDescription)
    }
    
}

extension Array : Log{
    func log() {
        print(debugDescription)
    }
}

extension Log{
    func log(){
        print(self)
    }
    
    func log(prefix : String?){
        if let prefix = prefix {
            print("\(prefix) :  \(self)")
        }
    }
}


