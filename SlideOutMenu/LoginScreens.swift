//
//  LoginScreens.swift
//  SlideOutMenu
//
//  Created by Yoh on 6/22/15.
//  Copyright (c) 2015 Harmony Bunny. All rights reserved.
//

import Foundation

class LoginScreens: UIViewController{

    @IBOutlet weak var tumblrLog: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tumblrLog.layer.cornerRadius = 10
    }

}