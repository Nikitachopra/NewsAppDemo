
//  CategoryViewController.swift
//  NewsAppDemo
//
//  Created by Vishal Chaurasia on 7/13/16.
//  Copyright © 2016 Vishal Chaurasia. All rights reserved.


import UIKit

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var categoryTableView: UITableView!

    var delgate: CategoryViewControllerDelegate!
    var categories = [Category]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if categories.count == 0 {
            NewsProviderService.fetchCategories{self.categories = $0;self.categoryTableView.reloadData()}
        }
        
        self.categoryTableView.dataSource = self
        self.categoryTableView.delegate = self
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = categoryTableView.dequeueReusableCellWithIdentifier("categories") as! CategoryCustomCell
        let category = categories[indexPath.row]
        cell.categoryNameLabel.text = category.categoryTitle
        cell.categoryIconimage.image = UIImage(named: Constants.IconImages.categoryIcons[category.categoryId]!)
        if category.categoryIsSelected {
            cell.categorySelectedImage.image = UIImage(named: Constants.IconImages.selectionImage)
        } else {
            cell.categorySelectedImage.image = nil
        }
            return cell
        }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let id = self.categories[indexPath.row].categoryId
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as! CategoryCustomCell
        if self.categories[indexPath.row].categoryIsSelected {
            selectedCell.categorySelectedImage.image = nil
            //NewsPageController.categories.remove(indexPath.row) on basis of element not on index path.row
            self.categories[indexPath.row].categoryIsSelected = false
        }else {
        selectedCell.categorySelectedImage.image = UIImage(named: Constants.IconImages.selectionImage)
            NewsPageController.categories.append(id)
            self.categories[indexPath.row].categoryIsSelected = true
        }
    }
    @IBAction func categoryViewTapped(sender: AnyObject) {
        NewsPageController.loadStories(false, completionHandler: {
            NewsPageController.page = 1
            //NewsPageController.activeStory = 0
        })
        NewsScreenViewController.categories = self.categories
        delgate.setIntial(0)
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
}

protocol CategoryViewControllerDelegate {
    func setIntial(index: Int)
}


