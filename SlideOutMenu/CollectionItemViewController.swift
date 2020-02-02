//
//  CollectionItemViewController.swift
//  SlideOutMenu
//
//  Created by Yoh on 6/15/15.
//  Copyright (c) 2015 Harmony Bunny. All rights reserved.
//

import UIKit

protocol Item {
    var category: ItemType { get }
    var title: String { get }
}


class BasicItem: Item {
    let category: ItemType
    let title: String
    let image: UIImage!
    
    init(title: String, image: UIImage, category: ItemType) {
        self.category = category
        self.title = title
        self.image = image
    }
}

class ShotCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.borderColor = UIColor(white: 3.0, alpha: 1.0).CGColor
        imageView.layer.borderWidth = 1
        
    }

}

class CollectionItemViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var openMenuButton: UIBarButtonItem!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var exploreButton: UIButton!
    @IBOutlet weak var favoritesButton: UIButton!
    
    @IBOutlet var layout: UICollectionViewFlowLayout!
    
    var varView: ItemType = .AllTypes
    
    var shots: [Shots]!
    var filteredShots :[Shots]!
    
    var cellHeight: CGFloat = 125
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        openMenuButton.target = self.revealViewController()
        openMenuButton.action = Selector("revealToggle:")
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("categoryChangeNotificationReceived:"),
            name: "SelectedCategoryChange",
            object: nil)
        navigationItem.title = SharedAppState.selectedTab.title
        Label.text =  SharedAppState.selectedCategory.title
        exploreButton.selected = true
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let cellWidth = self.view.frame.width/3
        layout.itemSize = CGSizeMake(cellWidth, cellHeight)
        
        shots = [Shots]()
        filteredShots = shots
        let api = DribbbleApi()
        
        
        
        api.loadShots({ self.didLoadShots($0) })
        
        //View controllers inside navigation doesn't use the "preferredStatusBarStyle" instead the
        //app queries the navigation controller, so we need to edit it
        self.navigationController!.navigationBar.barStyle = UIBarStyle.Black;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showShotDetail"
        {
            let shotIndexPath: NSIndexPath = self.collectionView.indexPathsForSelectedItems().first! as! NSIndexPath
            let shot = self.shots[shotIndexPath.row]
            let shotDetailViewController = segue.destinationViewController as! ShotDetailViewController
            
            shotDetailViewController.shot = shot
        }
    }
    
    func didLoadShots(shots: [Shots]){
        self.shots = shots
        self.filterShotsByCurrentFilter()
    }
    
    @IBAction func FavoriteHandlr(sender: UIButton) {
        navigationItem.title = "Hearted"
       
        favoritesButton.selected = true
        exploreButton.selected = false
    }
    @IBAction func ExploreHandlr(sender: UIButton) {
        navigationItem.title = "Explore"
        exploreButton.selected = true
        favoritesButton.selected = false
    }
    
    func tabButtonHandler(button: UIButton) {
        switch button {
        case favoritesButton:
            SharedAppState.selectedTab = .FavoritesTab
        case exploreButton:
            SharedAppState.selectedTab = .ExploreTab
        default:
            break
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filterShotsByCurrentFilter() {
        if varView == .AllTypes {
            filteredShots = shots
        } else {
            filteredShots = shots.filter{contains($0.tags, self.varView.title.lowercaseString)}
        }
        
        collectionView.reloadData()
        setTitle()
    }
    
    func categoryChangeNotificationReceived(notification: NSNotification) {
        varView = SharedAppState.selectedCategory
        self.filterShotsByCurrentFilter()
    }
    
    func setTitle() {
        Label.text = varView.title
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }

}

extension CollectionItemViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredShots.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let shot = filteredShots[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ShotCell", forIndexPath: indexPath)as! ShotCell
        cell.imageView.image = nil;
        asyncLoadShotImage(shot, imageview: cell.imageView)
        
        ////////////////////////
        
    
        return cell
        
    }
    
    func asyncLoadShotImage(shot: Shots, imageview: UIImageView){
        let downloadQueue = dispatch_queue_create("com.SlideOutMenu.processdownload",nil)
        
        dispatch_async(downloadQueue, { () -> Void in
            var data = NSData(contentsOfURL: NSURL(string: shot.imageUrl )!)
            var image: UIImage?
            if data != nil{
                shot.imageData = data
                image = UIImage(data: data!)!
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                imageview.image = image
            })
            
        })
    }
}