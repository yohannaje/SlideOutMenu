//
//  DribbbleApi.swift
//  SlideOutMenu
//
//  Created by Yoh on 6/22/15.
//  Copyright (c) 2015 Harmony Bunny. All rights reserved.
//

import Foundation

class DribbbleApi{

    let accessToken = "9ac95b3154e3c791132ce73ff607897f895a0a5f6c98b6dc91f9090b1563f49e"

    func loadShots(completion:(([Shots]) -> Void!)){
        
        var urlString = "https://api.dribbble.com/v1/shots?per_page=36&page=2&access_token=" + accessToken
        
        let session = NSURLSession.sharedSession()
        let shotsUrl = NSURL(string: urlString)
        
        var task = session.dataTaskWithURL(shotsUrl!){
        (data, response, error) -> Void in
            
            if error != nil{
                println(error.localizedDescription)
            } else {
                var error: NSError?
                
                var shotsData = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &error) as! NSArray
                
                var shots = [Shots]()
                for shot in shotsData{
                    let shot = Shots(data: shot as! NSDictionary)
                    
                    shots.append(shot)
                    
                }
                //Now that we have all the "shots" let's execute the completion block 
                //And send the shots back so another part of the code can use them
                //(calling completition would execute 'didLoadShots' on 'CollectionItemViewController'
                //We also need to do this on the main thread so nothing weird happens if the UI is updated
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completion(shots)
                })
            }
        }
        
        task.resume()
    
    }
}