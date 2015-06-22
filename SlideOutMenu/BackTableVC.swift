//
//  BackTableVC.swift
//  SlideOutMenu
//
//  Created by Yoh on 6/14/15.
//  Copyright (c) 2015 Harmony Bunny. All rights reserved.
//

import Foundation



class BackTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var photoSwitch: UISwitch!
    @IBOutlet weak var musicSwitch: UISwitch!
    @IBOutlet weak var textSwitch: UISwitch!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemType.MaxRawValue
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        if let itemType = ItemType(rawValue: indexPath.row) {
            cell.textLabel?.text = itemType.title
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let destinationVarView = ItemType(rawValue: indexPath.row) {
            SharedAppState.selectedCategory = destinationVarView
            NSLog("categories: \(SharedAppState.selectedCategory.title)")
            self.revealViewController().revealToggle(nil)
        }
    }
}