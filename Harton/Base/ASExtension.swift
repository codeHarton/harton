//
//  ASExtension.swift
//  Harton
//
//  Created by harton on 2021/8/30.
//

import Foundation
import AsyncDisplayKit
import Kingfisher

public class ASImageProtocolServcie{
    public static func getService() ->(ASImageCacheProtocol & ASImageDownloaderProtocol){
        return as_image_service
    }
    
    static let as_image_service = ASImagePortocolImpl()

}


extension KingfisherWrapper where Base : UIImageView{
    
}


public class ASImagePortocolImpl : NSObject,ASImageCacheProtocol,ASImageDownloaderProtocol{
    public func downloadImage(with URL: URL, callbackQueue: DispatchQueue, downloadProgress: ASImageDownloaderProgress?, completion: @escaping ASImageDownloaderCompletion) -> Any? {
        KingfisherManager.shared.retrieveImage(with: URL,options: [.processor(BlackWhiteProcessor())]) { result in
            switch result{
            case let .failure(error):
                let container = ImageContainer(image: nil, data: nil)
                completion(container,error,URL.cacheKey,nil)
            case let .success(response):
                let container = ImageContainer(image: response.image, data: nil)
                completion(container,nil,URL.cacheKey,nil)
            }
        }
        return URL
    }
    
    public func cancelImageDownload(forIdentifier downloadIdentifier: Any) {
        if let _url = downloadIdentifier as? URL {
            KingfisherManager.shared.downloader.cancel(url: _url)
        }
    }
    
    public func cachedImage(with URL: URL, callbackQueue: DispatchQueue, completion: @escaping ASImageCacherCompletion) {
        var image = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: URL.cacheKey, options: [.processor(BlackWhiteProcessor())])
        if nil == image {
            image = KingfisherManager.shared.cache.retrieveImageInDiskCache(forKey: URL.cacheKey,options: [.processor(BlackWhiteProcessor())])
        }
        let container = ImageContainer(image: image, data: nil)
        completion(container,ASImageCacheType.asynchronous)
    }
}



class ImageContainer: NSObject, ASImageContainerProtocol {
    let image : UIImage?
    let data : Data?
    init(image : UIImage?,data : Data?){
        self.image = image
        self.data = data
        super.init()
    }
    func asdk_image() -> UIImage? {
        return image
    }
    func asdk_animatedImageData() -> Data? {
        return data
    }
}
