//
//  ViewController.swift
//  MIOPhotoBrowser
//
//  Created by Maxence Henneron on 10/03/2016.
//  Copyright (c) 2016 Maxence Henneron. All rights reserved.
//

import UIKit
import SDWebImage
import MIOPhotoBrowser

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        let catImages = ["https://pixabay.com/static/uploads/photo/2014/03/29/09/17/cat-300572_1280.jpg",
                         "https://pixabay.com/static/uploads/photo/2014/11/07/18/00/cat-520894_1280.jpg",
                         "https://pixabay.com/static/uploads/photo/2016/09/07/22/38/cat-1652822_1280.jpg",
                         "https://pixabay.com/static/uploads/photo/2015/02/25/17/56/cat-649164_1280.jpg",
                         "https://images.unsplash.com/photo-1455970022149-a8f26b6902dd?dpr=2&auto=format"]
        var mioImages: [MIOPhoto] = []
        
        for image in catImages {
            mioImages.append(MIOPhoto(photoURL: image))
        }
        
        let browser = MIOPhotoBrowser(photos: mioImages)
        self.present(browser, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

