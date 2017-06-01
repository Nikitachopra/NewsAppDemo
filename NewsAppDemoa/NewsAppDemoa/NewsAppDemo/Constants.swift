//
//  Constants.swift
//  NewsAppDemo
//
//  Created by Vishal Chaurasia on 7/12/16.
//  Copyright © 2016 Vishal Chaurasia. All rights reserved.
//

import Foundation
import UIKit
struct Constants {
   
    
    
    struct Methods {
        static let url = "http://news.vaetas.com/"
        static let stories = "stories"
        static let categories = "categories"
    }
    struct IconImages {
        static let categoryIcons = [4:"ContentMangerIcon", 3:"DigitalAdvertisingIcon", 5:"SalesMarketingIcon", 1:"SEOIcon", 2:"SocialMediaIcon"]
        static let selectionImage = "Tick"
        static let reloadIcon = "ReloadIcon"
        static let optionsIcon = "OptionsIcon"
        static let openCategoriesIcon = "OpenCategoriesIcon"
        static let reloadingIcon = "ReloadingIcon"
        static let likeEmpty = "LikeEmpty"
        static let likeFilled = "LikeFilled"
        static let reloadedStories = "ReloadedStories"
        static let reloadingStories = "ReloadingStories"

    }
    enum Selection {
        case Few
        case NoSelection
    }
    struct Storyboards {
        static let showCategoryView = "show_category_view"
        static let newsViewController = "news_view_controller"
        static let shakeToSee = "shake_me_to_see_random_news"
    }
    struct Notifications {
        static let APP_DID_ENTER_BACKGROUND = "app_did_enter_background"
        static let APP_WILL_START = "app_will_start"
    }
    struct Animations {
        static let initialBarPosition = CGPoint(x: 0, y: -57)
        static let finalBarPosition = CGPoint(x: 0, y: 20)
        static let initialLabelPosition = CGPoint(x: 240, y: 550)
        static let finalLabelPosition = CGPoint(x: 240, y: 600)
    }
}