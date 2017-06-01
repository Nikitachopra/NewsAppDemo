//
//  NewsScreenView.swift
//  NewsAppDemo
//
//  Created by Vishal Chaurasia on 7/12/16.
//  Copyright © 2016 Vishal Chaurasia. All rights reserved.
//

import UIKit

@IBDesignable class NewsScreenView: UIView {
    
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsContentTextView: UITextView!
    @IBOutlet weak var newsDomainLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var publishedTimeLabel: UILabel!
    
    var delegate: NewsScreenViewDelegate!
    
    var isNewsRead = false
    private var likeOn = false
    private var alreadyFav = false
    
    //Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    private func setup(){
        let bundle = NSBundle(forClass: self.dynamicType)
        let NewsScreenViewNib = UINib(nibName: "NewsScreenView", bundle: bundle)
        
        let newsScreenViews = NewsScreenViewNib.instantiateWithOwner(self, options: nil) as! [UIView]
        let firstView = newsScreenViews[0]
        
        self.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        
        self.addSubview(firstView)
    }
    
    // methods to be called on user interactions
    @IBAction func tapped(sender: AnyObject) {
        print("Toggle between Liking and Unliking a News")
        if likeOn {
            likeOn = false
            self.likeImageView.image = UIImage(named: Constants.IconImages.likeEmpty)
        }else {
            likeOn = true
            self.likeImageView.image = UIImage(named: Constants.IconImages.likeFilled)
        }
        
    }
    @IBAction func titleTapped(sender: UITapGestureRecognizer) {
        if alreadyFav {
            alreadyFav = false
            self.newsTitleLabel.textColor = UIColor.blackColor()
        }else {
            alreadyFav = true
            self.newsTitleLabel.textColor = UIColor.redColor()
        }
        delegate.favSelected(alreadyFav)
    }
    @IBAction func requestToOpenURL(sender: UITapGestureRecognizer) {
        delegate.openURL(newsDomainLabel.text!)
    }
    @IBAction func shareButtonPressed() {
        print("Open Share Dialog Box and send Screenshot with a link to download our app")
        delegate.shareMe()
    }
    @IBAction func newsTossed() {
        print("news tossed")
        delegate.iAmTossed()
    }
}
protocol NewsScreenViewDelegate {
    func openURL(url:String)
    func favSelected(isSelected: Bool)
    func shareMe()
    func iAmTossed()
}