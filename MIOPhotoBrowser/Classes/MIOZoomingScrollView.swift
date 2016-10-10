//
//  MIOZoomingScrollView.swift
//  Pods
//
//  Created by Maxence Henneron on 10/3/16.
//
//

import UIKit

public class MIOZoomingScrollView: UIScrollView {
    
    // MARK: - Constraints for the media view
    var leftMediaViewConstraint: NSLayoutConstraint!
    var rightMediaViewConstraint: NSLayoutConstraint!
    var topMediaViewConstraint: NSLayoutConstraint!
    var bottomMediaViewConstraint: NSLayoutConstraint!
    
    var lastZoomScale: CGFloat = -1
    var photoBrowser: MIOPhotoBrowser?
    
    var photo: MIOPhotoProtocol {
        didSet {
            photoImageView.image = nil
        }
    }
    
    // MARK: - Controls creationI 
    open lazy var photoImageView: UIImageView = {
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = UIColor.yellow
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    // MARK: - Object lifecycle
    init(photo: MIOPhotoProtocol) {
        self.photo = photo
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(photoImageView)
        
        // Setting the various constraints
        leftMediaViewConstraint = photoImageView.leftAnchor.constraint(equalTo: self.leftAnchor)
        rightMediaViewConstraint = photoImageView.rightAnchor.constraint(equalTo: self.rightAnchor)
        topMediaViewConstraint = photoImageView.topAnchor.constraint(equalTo: self.topAnchor)
        bottomMediaViewConstraint = photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        [leftMediaViewConstraint, rightMediaViewConstraint, topMediaViewConstraint, bottomMediaViewConstraint].forEach({
            constraint in
            constraint.isActive = true
        })

        delegate = self
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    public func loadImage(){
        photo.loadUnderlyingImageAndNotify()
    }
    
    public func updateMediaViewConstraints() {
        if let image = photoImageView.image {
            let imageWidth = image.size.width
            let imageHeight = image.size.height
            
            let viewWidth = bounds.size.width
            let viewHeight = bounds.size.height
            
            // center image if it is smaller than the scroll view
            var hPadding = (viewWidth - zoomScale * imageWidth) / 2
            if hPadding < 0 { hPadding = 0 }
            
            var vPadding = (viewHeight - zoomScale * imageHeight) / 2
            if vPadding < 0 { vPadding = 0 }
            
            leftMediaViewConstraint.constant = hPadding
            rightMediaViewConstraint.constant = hPadding
            
            topMediaViewConstraint.constant = vPadding
            bottomMediaViewConstraint.constant = vPadding
            
            self.layoutIfNeeded()
        }
    }

    // Zoom to show as much image as possible unless image is smaller than the scroll view
    public func updateZoom() {
        if let image = photoImageView.image {
            var minZoom = min(bounds.size.width / image.size.width,
                              bounds.size.height / image.size.height)
            
            if minZoom > 1 { minZoom = 1 }
            
            minimumZoomScale = minZoom
            
            // Force scrollViewDidZoom fire if zoom did not change
            if minZoom == lastZoomScale { minZoom += 0.000001 }
            
            zoomScale = minZoom
            lastZoomScale = minZoom
        }
    }
    
    public func displayImage() {
        if let image = photo.underlyingImage {
            self.photoImageView.image = image
            layoutIfNeeded()
            updateZoom()
        }
    }
}

extension MIOZoomingScrollView: UIScrollViewDelegate {
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateMediaViewConstraints()
    }
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
}
