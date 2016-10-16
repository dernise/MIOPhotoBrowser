//
//  MIOPhotoViewController.swift
//  Pods
//
//  Created by Maxence Henneron on 10/8/16.
//
//

import UIKit

class MIOPhotoViewController: UIViewController {
    lazy var zoomingScrollView: MIOZoomingScrollView = {
        let v = MIOZoomingScrollView(photo: self.photo)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var photo: MIOPhotoProtocol
    
    required init(_ photo: MIOPhotoProtocol) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleMIOPhotoLoadingDidEndNotification(_:)), name: NSNotification.Name(rawValue: MIOPHOTO_LOADING_DID_END_NOTIFICATION), object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.addSubview(zoomingScrollView)
        zoomingScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        zoomingScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        zoomingScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        zoomingScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        zoomingScrollView.bouncesZoom = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (photo.underlyingImage == nil) {
            zoomingScrollView.loadImage()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Orientation Change
    override public func viewWillTransition(to size: CGSize,
                                            with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] _ in
                self?.zoomingScrollView.updateZoom()
            }, completion: nil)
    }
    
    // MARK: - Notification
    open func handleMIOPhotoLoadingDidEndNotification(_ notification: Notification) {
        guard let notificationPhoto = notification.object as? MIOPhotoProtocol else {
            return
        }
        
        DispatchQueue.main.async(execute: {
            if notificationPhoto.underlyingImage != nil  {
                self.zoomingScrollView.displayImage()
            } else {
            }
        })
    }
}
