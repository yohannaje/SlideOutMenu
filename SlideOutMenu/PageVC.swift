//
//  ContentViewController.swift
//  SlideOutMenu
//
//  Created by Yoh on 6/22/15.
//  Copyright (c) 2015 Harmony Bunny. All rights reserved.
//

import Foundation

class PageVC : UIViewController, UIPageViewControllerDataSource{
    
    var pageViewController: UIPageViewController!
    var pageImages: NSArray!
    var pageTitle: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageTitle = NSArray(objects: "Tumblr Login", "Dribbble Login", "Pinterest Login")
        self.pageImages = NSArray(objects: "tumblr", "dribbble", "pinterest")
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        var startVC = self.viewControllerAtIndex(0) as LoginScreens
        
        var viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as [AnyObject], direction: .Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.size.height - 90)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        
    }
    
    func viewControllerAtIndex(Index: Int) -> LoginScreens {
        
        if ((self.pageTitle.count == 0 || Index >= self.pageTitle.count)){
        
            return LoginScreens()
        }
        var vc: LoginScreens = self.storyboard?.instantiateViewControllerWithIdentifier("LoginScreens") as! LoginScreens
        
        vc.imageFile = self.pageImages[Index] as! String
        vc.titleText = self.pageTitle[Index] as! String
        vc.pageIndex = Index
        
        return vc
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! LoginScreens
        var index = vc.pageIndex as Int
        
        if (index == 0) || (index == NSNotFound){
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var vc = viewController as! LoginScreens
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound){
            return nil
        }
        
        index++
        
        if (index == self.pageTitle.count){
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitle.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    
    
    
    
    
    
    
}