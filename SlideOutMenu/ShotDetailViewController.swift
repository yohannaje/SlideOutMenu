//
//  ShotDetailViewController.swift
//  SlideOutMenu
//
//  Created by Yoh on 6/30/15.
//  Copyright (c) 2015 Harmony Bunny. All rights reserved.
//

import Foundation


class ShotDetailViewController: UIViewController {

    var shot : Shots?
    
    override func viewDidLoad() {
        
        print(shot)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let shotImage = UIImage(data: shot!.imageData!)
        self.shotImage!.image = shotImage
    }
    
    @IBOutlet weak var shotImage: UIImageView?
    
}