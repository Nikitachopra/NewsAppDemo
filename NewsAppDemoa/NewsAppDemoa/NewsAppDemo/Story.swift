//
//  Stories.swift
//  NewsAppDemo
//
//  Created by Vishal Chaurasia on 7/13/16.
//  Copyright © 2016 Vishal Chaurasia. All rights reserved.
//

import Foundation
import UIKit
class Story {
    
    let title: String
    let descriptions: String
    let article_link: String
    let thumbnail_url: String
    let publishedAt: NSDate
    var favourite = false
    var read = false
    var storyImage: UIImage!
    
    init(title: String, description: String, article_link: String, thumbnail_url: String, publishedAt: NSDate) {
        self.title = title
        self.descriptions = description
        self.article_link = article_link
        self.thumbnail_url = thumbnail_url
        self.publishedAt = publishedAt
    }
    
}