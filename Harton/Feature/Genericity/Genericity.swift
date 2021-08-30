//
//  Genericity.swift
//  Harton
//
//  Created by harton on 2021/8/30.
//

import Foundation


import Kingfisher
class Genericity<T> {
    
    
    func run(t : T){
        let button = UIButton()
        button.kf.setImage(with: URL(string: ""), for: .normal)
        
        KingfisherManager.shared.downloader.downloadImage(with: URL(string: "")!, options: [.requestModifier(AnyModifier(modify: { reuqest in
            return reuqest
        })),.callbackQueue(.mainCurrentOrAsync)], progressBlock: nil) { result in
            
        }
    }

}

