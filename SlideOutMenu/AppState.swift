//
//  AppState.swift
//  SlideOutMenu
//
//  Created by Yoh on 6/15/15.
//  Copyright (c) 2015 Harmony Bunny. All rights reserved.
//

import UIKit

enum ItemType: Int {
    case AllTypes = 0
    case PeopleViewType = 1
    case CityViewType = 2
    case LoveViewType = 3
    case NatureViewType = 4
    case BWViewType = 5
    case ArchitectureViewType = 6
    case DesignViewType = 7
    case ArtViewType = 8
    case LandscapesViewType = 9
    case MiscViewType = 10

    var title: String {
        get {
            switch self {
            case .AllTypes: return "All"
            case .PeopleViewType: return "People"
            case .CityViewType: return "City"
            case .LoveViewType: return "Love"
            case .NatureViewType: return "Nature"
            case .BWViewType: return "B & W"
            case .ArchitectureViewType: return "Architecture"
            case .DesignViewType: return "Design"
            case .ArtViewType: return "Art"
            case .LandscapesViewType: return "Landscapes"
            case .MiscViewType: return "Misc"
                
            }
        }
    }
    
    static var MaxRawValue: Int {
        get {
            return 11
        }
    }
}

enum Tabs: Int {
    case ExploreTab = 0
    case FavoritesTab = 1
    
    var title: String{
        get {
            switch self{
            case .ExploreTab: return "Explore"
            case .FavoritesTab: return "Hearted"
            }
        }
    }
}

class AppState {
    var selectedCategory: ItemType = .AllTypes {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName("SelectedCategoryChange", object: self)
        }
    }
    var selectedTab: Tabs = .ExploreTab
    var selectedMediaTypes: [Int] = []
}

let SharedAppState = AppState()
