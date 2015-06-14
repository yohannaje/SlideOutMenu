//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by Yoh on 6/14/15.
//  Copyright (c) 2015 Harmony Bunny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    enum ViewTypes: Int {
        case LandscapesViewType = 0
        case PeopleViewType = 1
        case CityViewType = 2
        case LoveViewType = 3
        case NatureViewType = 4
        case BWViewType = 5
        case ArchitectureViewType = 6
        case DesignViewType = 7
        case ArtViewType = 8
        case MiscViewType = 9
        
    }
    
    @IBOutlet weak var Open: UIBarButtonItem!
   
    @IBOutlet weak var Label: UILabel!
    
    var varView: ViewTypes = .MiscViewType
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        switch varView {
        case .BWViewType:
            Label.text = "BW"
        case .LandscapesViewType:
            Label.text = "Landscapes"
        case .ArchitectureViewType:
            Label.text = "Architecture"
        case .CityViewType:
            Label.text = "City"
        case .DesignViewType:
            Label.text = "Design"
        case .LoveViewType:
            Label.text = "Love"
        case .NatureViewType:
            Label.text = "Nature"
        case .MiscViewType:
            Label.text = "Misc"
        case .PeopleViewType:
            Label.text = "People"
        case .ArtViewType:
            Label.text = "Art"
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

}

