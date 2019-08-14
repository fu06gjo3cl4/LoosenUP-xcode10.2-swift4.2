//
//  ImageCache.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/14.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import Foundation
import UIKit

class CustomImageCache {
    
    static let sharedCache: NSCache = { () -> NSCache<AnyObject, AnyObject> in
        let cache = NSCache<AnyObject, AnyObject>()
        cache.name = "MyImageCache"
//        cache.countLimit = 20 // Max 20 images in memory.
        cache.totalCostLimit = 10*1024*1024 // Max 10MB used.
        return cache
    }()
    
}

extension NSURL {
    
    typealias ImageCacheCompletion = (UIImage) -> Void
    
    
    var cachedImage: UIImage? {
        return CustomImageCache.sharedCache.object(
            forKey: absoluteString as AnyObject) as? UIImage
    }
    
    func fetchImage(completion: @escaping ImageCacheCompletion) {
        // 如果需要客製化取得資料在此做
        let task = URLSession.shared.dataTask(with: self as URL) {
            data, response, error in
            if error == nil {
                if let data = data, let image = UIImage(data: data) {
                    CustomImageCache.sharedCache.setObject(
                        image,
                        forKey: self.absoluteString as AnyObject,
                        cost: data.count)
                    DispatchQueue.main.async() {
                        completion(image)
                    }
                }
            }
        }
        task.resume()
    }
    
}









//import  UIKit
//
//class ImageCache {
//
//    static let shared = ImageCache()
//
//    private let cache = NSCache<NSString, UIImage>()
//    var task = URLSessionDataTask()
//    var session = URLSession.shared
//
//    func imageFor(url: URL, completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
//        if let imageInCache = self.cache.object(forKey: url.absoluteString as NSString)  {
//            completionHandler(imageInCache, nil)
//            return
//        }
//
//        self.task = self.session.dataTask(with: url) { data, response, error in
//
//            if let error = error {
//                completionHandler(nil, Error.self as! Error)
//                return
//            }
//
//            let image = UIImage(data: data!)
//
//            self.cache.setObject(image!, forKey: url.absoluteString as NSString)
//            completionHandler(image, nil)
//        }
//
//        self.task.resume()
//    }
//}
