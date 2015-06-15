//
//  AppState.swift
//  SlideOutMenu
//
//  Created by Nicolas Ameghino on 6/15/15.
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
            default: return "TooLazyException"
            }
        }
    }
    
    static var MaxRawValue: Int {
        get {
            return 11
        }
    }
}

class AppState {
    var selectedCategory: ItemType = .AllTypes {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName("SelectedCategoryChange", object: self)
        }
    }
    var selectedMediaTypes: [Int] = []
}

let SharedAppState = AppState()
