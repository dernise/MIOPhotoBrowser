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
        let browser = MIOPhotoBrowser(photos: [MIOPhoto(photoURL: "https://pixabay.com/static/uploads/photo/2014/03/29/09/17/cat-300572_1280.jpg"), MIOPhoto(photoURL: "https://pixabay.com/static/uploads/photo/2014/11/07/18/00/cat-520894_1280.jpg")])
        self.present(browser, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

