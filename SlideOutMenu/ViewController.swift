//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by Yoh on 6/14/15.
//  Copyright (c) 2015 Harmony Bunny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var open: UIBarButtonItem!
   
    @IBOutlet weak var catLabel: UILabel!
    
    var varView: ItemType = .AllTypes
    
    func categoryChangeNotificationReceived(notification: NSNotification) {
        varView = SharedAppState.selectedCategory
        setTitle()
    }
    
    func setTitle() {
        switch varView {
        case .AllTypes:
            catLabel.text = "All"
        case .BWViewType:
            catLabel.text = "BW"
        case .LandscapesViewType:
            catLabel.text = "Landscapes"
        case .ArchitectureViewType:
            catLabel.text = "Architecture"
        case .CityViewType:
            catLabel.text = "City"
        case .DesignViewType:
            catLabel.text = "Design"
        case .LoveViewType:
            catLabel.text = "Love"
        case .NatureViewType:
            catLabel.text = "Nature"
        case .MiscViewType:
            catLabel.text = "Misc"
        case .PeopleViewType:
            catLabel.text = "People"
        case .ArtViewType:
            catLabel.text = "Art"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("categoryChangeNotificationReceived:"),
                name: "SelectedCategoryChange",
                object: nil)
        
        open.target = self.revealViewController()
        open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        setTitle()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

}

