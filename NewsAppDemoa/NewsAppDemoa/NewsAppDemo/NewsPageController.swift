//
//  NewsPageController.swift
//  NewsAppDemo
//
//  Created by Vishal Chaurasia on 7/14/16.
//  Copyright © 2016 Vishal Chaurasia. All rights reserved.
//

import UIKit
import CoreData

class NewsPageController: UIPageViewController, UIPageViewControllerDataSource, NewsScreenViewControllerDelegate {
    
    static var stories = [Story]()
    static var categories = [Int]()
    static var page = 1
    static let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(saveMeInCoreData), name: Constants.Notifications.APP_DID_ENTER_BACKGROUND, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(retrieveDataFromCoreData), name: Constants.Notifications.APP_WILL_START, object: nil)
        
        
        if NewsPageController.stories.count == 0 {
            NewsProviderService.fetchStories(NewsPageController.page, categories: NewsPageController.categories){
                NewsPageController.stories = $0
                self.initialSetup(0)
            }
        }
        else {
            // retrieve stories from core data and and add to stories variable.
            print("")
        }
        self.dataSource = self
    }
    
    func initialSetup(index: Int)  {
        self.setViewControllers([self.viewControllerAtIndex(index)!], direction: .Forward, animated: true, completion: nil)
    }
    
    class func loadStories(lastPageReached: Bool, completionHandler: (() -> Void)?) {
        NewsProviderService.fetchStories(NewsPageController.page, categories: NewsPageController.categories){
            print("Success")
            if lastPageReached {
            NewsPageController.stories += $0
            }else {
                NewsPageController.stories = $0
            }
            completionHandler?()
        }
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
        let view = viewController as! NewsScreenViewController
        var index = view.pageIndex
        if index == 0{
            return nil
        }
        index = index - 1
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let view = viewController as! NewsScreenViewController
        var index = view.pageIndex
        
        index = index + 1
        
        return self.viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> NewsScreenViewController? {
        print("\(index)q")
        if NewsPageController.stories.count == 0 {
            return nil
        }else  if index == NewsPageController.stories.count - 2{
            NewsPageController.page += 1
            print(NewsPageController.page)
            NewsPageController.loadStories(true, completionHandler: nil)
        }
        else if index == NewsPageController.stories.count {
            NewsPageController.page += 1
            NewsPageController.loadStories(true, completionHandler: nil) // if agar by chance yahn paunha to reload window
        }
        let destinationVC = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.Storyboards.newsViewController) as! NewsScreenViewController
        destinationVC.delegate = self
        //destinationVC.dataSource = self
        destinationVC.story = NewsPageController.stories[index]
        destinationVC.pageIndex = index

        
        return destinationVC
    }
    
    // Core data related functions for saving and retrieving
    func retrieveDataFromCoreData() {
        //        let fetchRequest = NSFetchRequest(entityName: "News")
        //        let result = try! appdelegate.managedObjectContext.executeFetchRequest(fetchRequest) as! [News]
        //        for eachResult in 0...result.count {
        ////            stories[eachResult] = Story(title: result[eachResult].title!, description: result[eachResult].short_story!, article_link: result[eachResult].article_link!, thumbnail_url: result[eachResult].article_image!, publishedAt: result[eachResult].published_at!) // uiimage transfeer to nsdata and
        //        }
        print("retreived")
    }
    func saveMeInCoreData() {
//        for eachStory in stories {
//            let insertedRow = NSEntityDescription.insertNewObjectForEntityForName("News", inManagedObjectContext: appdelegate.managedObjectContext) as! News
//            insertedRow.title = eachStory.title
//            insertedRow.short_story = eachStory.descriptions
//            insertedRow.article_link = eachStory.article_link
//            insertedRow.favourite = eachStory.favourite
//            insertedRow.read = eachStory.read
//            insertedRow.published_at = eachStory.publishedAt
//            //insertedRow.article_image //eachStory.thumbnail_url
//            try! appdelegate.managedObjectContext.save()
//        }
        print("saved")
        
    }
    
    //motion handle functions
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            let destinationVC = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.Storyboards.shakeToSee) as! ShakeForNewsViewController
            destinationVC.story = NewsPageController.stories[Int(arc4random_uniform(UInt32(NewsPageController.stories.count)))]
            self.showViewController(destinationVC, sender: nil)
        }
    }

    // delegate functions
    
    func setInitial(index: Int) {
        self.initialSetup(index)
    }
    
}
