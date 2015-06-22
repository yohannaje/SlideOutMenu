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

class ItemCollectionViewCell: UICollectionViewCell {
    //@IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    func setItem(item: BasicItem) {
        //label.text = item.title
        imageView.image = item.image
    }
}

class CollectionItemViewController: UIViewController {

    @IBOutlet weak var openMenuButton: UIBarButtonItem!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var exploreButton: UIButton!
    @IBOutlet weak var favoritesButton: UIButton!
    
    var items = [BasicItem]()
    var displayedItems = [BasicItem]()
    var varView: ItemType = .AllTypes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        openMenuButton.target = self.revealViewController()
        openMenuButton.action = Selector("revealToggle:")
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("categoryChangeNotificationReceived:"),
            name: "SelectedCategoryChange",
            object: nil)
        navigationItem.title = SharedAppState.selectedTab.title
        Label.text =  SharedAppState.selectedCategory.title
        exploreButton.selected = true
        
        

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
        return displayedItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = displayedItems[indexPath.item]
        if (SharedAppState.selectedTab.hashValue == 0){
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("exploreCell", forIndexPath: indexPath) as! ItemCollectionViewCell
            cell.setItem(item)
            return cell
        }else{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("favsCell", forIndexPath: indexPath) as! ItemCollectionViewCell
            cell.setItem(item)
            return cell
        }
        
    }
}
