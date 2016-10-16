//
//  MIOPhotoBrowser.swift
//  Pods
//
//  Created by Maxence Henneron on 10/3/16.
//
//

import UIKit

public let MIOPHOTO_LOADING_DID_END_NOTIFICATION = "photoLoadingDidEndNotification"

public class MIOPhotoBrowser: UIPageViewController {
    var photos: [MIOPhotoProtocol] = []
    var photosViewControllers: [UIViewController] = []
    var currentIndex: Int = 0

    // MARK: - Object Lifecycle
    public convenience init(photos: [MIOPhotoProtocol]) {
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.photos = photos
        for photo in photos {
            photosViewControllers.append(MIOPhotoViewController(photo))
        }

    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        if photosViewControllers.count > 0 {
            setViewControllers([photosViewControllers.first!], direction: .forward, animated: false, completion: nil)
        }
        
        dataSource = self
        delegate = self
    }
}
extension MIOPhotoBrowser: UIPageViewControllerDataSource {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = photosViewControllers.index(of: viewController) {
            if ( index > 0 ) {
                return photosViewControllers[index - 1]
            }
        }
        
        return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = photosViewControllers.index(of: viewController) {
            if ( index < photosViewControllers.count - 1 ) {
                return photosViewControllers[index + 1]
            }
        }
        return nil
    }

}

extension MIOPhotoBrowser: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        print("test")
    }
    
    //Keeping track of the index
    func pageViewController(pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool)
    {
        guard completed else { return }
        if let currentViewController = pageViewController.viewControllers?.first, let index = photosViewControllers.index(of: currentViewController) {
            currentIndex = index
        }
    }
}
