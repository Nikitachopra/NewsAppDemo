//
//  ViewController.swift
//  NewsAppDemo
//
//  Created by Vishal Chaurasia on 7/12/16.
//  Copyright © 2016 Vishal Chaurasia. All rights reserved.
//

import UIKit
import Kingfisher

class NewsScreenViewController: UIViewController, NewsScreenViewDelegate,  CategoryViewControllerDelegate {
    
    @IBOutlet weak var news: NewsScreenView!
    @IBOutlet weak var bar: UIView!
    @IBOutlet weak var reloadImageView: UIImageView!
    
    var delegate: NewsScreenViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(bar)

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
        
        news.delegate = self
        
        if story.favourite {
            news.newsTitleLabel.textColor = UIColor.redColor()
        }
//        let cal: NSCalendar = NSCalendar.currentCalendar()
//        cal.timeZone = NSTimeZone(forSecondsFromGMT: 0)
//        let newDate: NSDate = cal.get
//        print(newDate)
        let url = NSURL(string: story.thumbnail_url)!
        news.newsImageView.kf_setImageWithURL(url, placeholderImage: nil)
        news.newsTitleLabel.text = story.title
        news.newsContentTextView.text = story.descriptions
        news.newsDomainLabel.text! = story.article_link
        //print(date.offsetFrom(story.publishedAt))
        if let image = news.newsImageView.image {
        story.storyImage = image
        }
        story.read = true
    }
    
    func handleTap() {
        if toggleBar{
            toggleBar = false
            UIView.animateWithDuration(0.5, delay: 0.1, options: .CurveLinear, animations: {
                self.bar.frame.origin = Constants.Animations.initialBarPosition
                }, completion: nil)
            bar.hidden = false
        }else {
            toggleBar = true
            bar.hidden = false
            UIView.animateWithDuration(0.5, delay: 0.1, options: .CurveLinear, animations: {
                self.bar.frame.origin = Constants.Animations.finalBarPosition
                }, completion: nil)
        }
    }
    @IBAction func barTappedOpenCategories(sender: AnyObject) {
        let destinationVC = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.Storyboards.showCategoryView) as! CategoryViewController
        destinationVC.modalPresentationStyle = .OverCurrentContext
        destinationVC.modalTransitionStyle = .CoverVertical
        destinationVC.categories = NewsScreenViewController.categories
        destinationVC.delgate = self
        presentViewController(destinationVC, animated: true, completion: nil)
        }
    @IBAction func reloadStories(sender: AnyObject) {
        print("reload tapped")
        
        self.reloadImageView.image = UIImage(named: Constants.IconImages.reloadingIcon)
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = M_PI
        rotationAnimation.duration = 2.0
        self.reloadImageView.layer.addAnimation(rotationAnimation, forKey: "reloading")
        
        NewsPageController.loadStories(false){
            self.reloadImageView.layer.removeAllAnimations()
            self.reloadImageView.image = UIImage(named: Constants.IconImages.reloadIcon)
            self.delegate.setInitial(0)
        }
    }
    @IBAction func optionsTapped(sender: UITapGestureRecognizer) {
        
    }
    
    // delegate functions
    func openURL(url: String) {
        if let checkURL = NSURL(string: url) {
            if UIApplication.sharedApplication().openURL(checkURL) {
                print("url successfully opened")
            }
        } else {
            print("invalid url = \(url)")
        }
    }
    func favSelected(isSelected: Bool) {
        story.favourite = isSelected
        print(isSelected)
    }
    func shareMe() {
        
    }
    func iAmTossed() {
        
    }
    
    func setIntial(index: Int) {
        self.delegate.setInitial(0)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var story: Story!
    var pageIndex: Int!
    var toggleBar: Bool = false
    static var categories = [Category]()
}

protocol NewsScreenViewControllerDelegate {
    func setInitial(index: Int)
}

