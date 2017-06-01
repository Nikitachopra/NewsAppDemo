//
//  Category.swift
//  NewsAppDemo
//
//  Created by Vishal Chaurasia on 7/13/16.
//  Copyright © 2016 Vishal Chaurasia. All rights reserved.
//

import Foundation
class Category {
    
    let categoryId: Int
    let categoryTitle: String
    var categoryIsSelected: Bool
    
    init(id: Int, title: String) {
        self.categoryId = id
        self.categoryTitle = title
        self.categoryIsSelected = false
    }
}
