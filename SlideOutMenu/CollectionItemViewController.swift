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
        
        //imageView.layer.borderColor = UIColor(white: 0.2, alpha: 1.0).CGColor
        imageView.layer.borderWidth = 2
        
    }
    
//    func setItem(item: BasicItem) {
//        imageView.image = item.image
//    }
}

class CollectionItemViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var openMenuButton: UIBarButtonItem!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var exploreButton: UIButton!
    @IBOutlet weak var favoritesButton: UIButton!
    
    @IBOutlet var layout: UICollectionViewFlowLayout!
    
    var items = [BasicItem]()
    var displayedItems = [BasicItem]()
    var varView: ItemType = .AllTypes
    
    var shots: [Shots]!
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
        
        let cellWidth = self.view.frame.width/2
        layout.itemSize = CGSizeMake(cellWidth, cellHeight)
        
        shots = [Shots]()
        let api = DribbbleApi()
        
        api.loadShots({ self.didLoadShots($0) })

        //View controllers inside navigation doesn't use the "preferredStatusBarStyle" instead the
        //app queries the navigation controller, so we need to edit it
        self.navigationController!.navigationBar.barStyle = UIBarStyle.Black;
    }
    
    func didLoadShots(shots: [Shots]){
        self.shots = shots
        collectionView.reloadData()
        
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
    
   
    
    func categoryChangeNotificationReceived(notification: NSNotification) {
        varView = SharedAppState.selectedCategory
        if varView == .AllTypes {
            displayedItems = items
        } else {
            displayedItems = items.filter {
                [unowned self] item in
                return item.category == self.varView
            }
        }
        collectionView.reloadData()
        setTitle()
    }
    
    func setTitle() {
        Label.text = varView.title
    }
}

extension CollectionItemViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shots.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = shots[indexPath.item]
       
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ShotCell", forIndexPath: indexPath) as! ShotCell
            
            return cell
        }
        
}
