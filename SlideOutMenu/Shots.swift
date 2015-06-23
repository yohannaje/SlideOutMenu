
//
//  Shots.swift
//  SlideOutMenu
//
//  Created by Yoh on 6/22/15.
//  Copyright (c) 2015 Harmony Bunny. All rights reserved.
//

import Foundation

class Shots {
    var id: Int!
    var title: String!
    var imageUrl: String!
    
    var imageData: NSData?
    
    init (data: NSDictionary){
        self.id = data["id"] as! Int
        self.title = getStringFromJSON(data, key: "title")
        
        let images = data["images"] as! NSDictionary
        self.imageUrl = getStringFromJSON(images, key: "normal")
    }
    
    func getStringFromJSON(data: NSDictionary, key: String)->String{
        let info: AnyObject? = data[key]
        
        if let info = data[key] as? String{
            return info
        }
        return ""
    }
}