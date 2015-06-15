//
//  CollectionItemViewController.swift
//  SlideOutMenu
//
//  Created by Nicolas Ameghino on 6/15/15.
//  Copyright (c) 2015 Harmony Bunny. All rights reserved.
//

import UIKit

class Item {
    let category: ItemType
    let title: String!
    let image: UIImage!
    
    init(title: String, image: UIImage, category: ItemType) {
        self.category = category
        self.title = title
        self.image = image
    }
}

class ItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    func setItem(item: Item) {
        label.text = item.title
        imageView.image = item.image
    }
}

class CollectionItemViewController: UIViewController {

    @IBOutlet weak var openMenuButton: UIBarButtonItem!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var items = [Item]()
    var displayedItems = [Item]()
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellIdentifier", forIndexPath: indexPath) as! ItemCollectionViewCell
        cell.setItem(item)
        return cell
    }
}
