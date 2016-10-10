//
//  MIOPhoto.swift
//  Pods
//
//  Created by Maxence Henneron on 10/3/16.
//
//

import Foundation
import SDWebImage

@objc public protocol MIOPhotoProtocol: NSObjectProtocol {
    var underlyingImage: UIImage! { get }
    var caption: String! { get }
    var index: Int { get set}
    var contentMode: UIViewContentMode { get set }
    func loadUnderlyingImageAndNotify()
}

public class MIOPhoto: NSObject, MIOPhotoProtocol {
    public var contentMode: UIViewContentMode = .scaleAspectFill
    public var index: Int = 0
    public var caption: String!
    public var underlyingImage: UIImage!
    public var photoURL: String
    
    public init(photoURL: String) {
        self.photoURL = photoURL
    }
    
    public func loadUnderlyingImageAndNotify() {
        if underlyingImage != nil {
            loadUnderlyingImageComplete()
            return
        }
        
        let cache = SDImageCache.shared()
        if(cache?.diskImageExists(withKey: photoURL))!{
            underlyingImage = cache?.imageFromDiskCache(forKey: photoURL)
            loadUnderlyingImageComplete()
            return
        }
        
        let manager = SDWebImageManager.shared() //Image not cached previously - removing
        _ = manager?.downloadImage(with: URL(string: photoURL), options: SDWebImageOptions(), progress: {block in }, completed: { image, _, _, _, _ in
            self.underlyingImage = image
            self.loadUnderlyingImageComplete()
        })
    }
    
    internal func loadUnderlyingImageComplete() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: MIOPHOTO_LOADING_DID_END_NOTIFICATION), object: self)
    }
    
}
