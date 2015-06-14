//
//  BackTableVC.swift
//  SlideOutMenu
//
//  Created by Yoh on 6/14/15.
//  Copyright (c) 2015 Harmony Bunny. All rights reserved.
//

import Foundation

class BackTableVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var TableArray = [String]()
    
    override func viewDidLoad() {
        TableArray = ["Landascape","People","City","Love","Nature","B&W","Architecture","Design","Art","Misc"]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var DestVC = segue.destinationViewController as! ViewController
        
        var indexPath :NSIndexPath = self.tableView.indexPathForSelectedRow()!
        let destinationVarView: ViewController.ViewTypes
        switch indexPath.row {
        case 0:
            destinationVarView = .LandscapesViewType
        case 1:
            destinationVarView = .PeopleViewType
        case 2:
            destinationVarView = .CityViewType
        case 3:
            destinationVarView = .LoveViewType
        case 4:
            destinationVarView = .NatureViewType
        case 5:
            destinationVarView = .BWViewType
        case 6:
            destinationVarView = .ArchitectureViewType
        case 7:
            destinationVarView = .DesignViewType
        case 8:
            destinationVarView = .ArtViewType
        case 9:
            destinationVarView = .MiscViewType
        default:
            destinationVarView = .MiscViewType
        }
        
        DestVC.varView = destinationVarView
        
    }
}