//
//  ShakeForNewsViewController.swift
//  NewsAppDemo
//
//  Created by Vishal Chaurasia on 7/17/16.
//  Copyright © 2016 Vishal Chaurasia. All rights reserved.
//

import UIKit

class ShakeForNewsViewController: UIViewController {
    @IBOutlet var news: NewsScreenView!

    var story: Story!
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string: story.thumbnail_url)!
        news.newsImageView.kf_setImageWithURL(url, placeholderImage: nil)
        news.newsTitleLabel.text = story.title
        news.newsContentTextView.text = story.descriptions
        news.newsDomainLabel.text! = story.article_link
    }
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    //since it is not declaring itself as delegate class thats y problem is occuring once delgate is set it will work fine

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
