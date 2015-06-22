//
//  LoginScreens.swift
//  SlideOutMenu
//
//  Created by Yoh on 6/22/15.
//  Copyright (c) 2015 Harmony Bunny. All rights reserved.
//

import Foundation

class LoginScreens: UIViewController{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var tumblrLog: UIButton!
//    @IBOutlet weak var tumblrmail: UITextField!
//    @IBOutlet weak var tumblrpass: UITextField!
//   
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   //     tumblrLog.layer.cornerRadius = 10
        self.imageView.image = UIImage(named: self.imageFile)
        self.titleLabel.text = self.titleText
    }

//    @IBAction func SaveMail(sender: UITextField) {
//        let mail = tumblrmail.text
//        
//    }
//    
//    @IBAction func SavePasswd(sender: UITextField) {
//        let passwd = tumblrpass.text
//    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default;
    }
    
}