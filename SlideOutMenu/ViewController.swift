//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by Yoh on 6/14/15.
//  Copyright (c) 2015 Harmony Bunny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Open: UIBarButtonItem!
   
    @IBOutlet weak var Label: UILabel!
    
    var varView: ItemType = .MiscViewType
    
    func categoryChangeNotificationReceived(notification: NSNotification) {
        varView = SharedAppState.selectedCategory
        setTitle()
    }
    
    func setTitle() {
        switch varView {
        case .AllTypes:
            Label.text = "All"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("categoryChangeNotificationReceived:"),
                name: "SelectedCategoryChange",
                object: nil)
        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        setTitle()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

}

