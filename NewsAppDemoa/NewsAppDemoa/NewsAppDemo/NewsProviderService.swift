//
//  NewsProviderService.swift
//  NewsAppDemo
//
//  Created by Vishal Chaurasia on 7/12/16.
//  Copyright © 2016 Vishal Chaurasia. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import Kingfisher

class NewsProviderService {
    
    class func fetchStories(page: Int,categories: [Int], completionHandler: [Story] -> Void){
        if categories.count == 0 {
            Alamofire.request(.GET, Constants.Methods.url+Constants.Methods.stories+"?page=\(page)").responseJSON {
                completionHandler(sendValues(JSON($0.result.value!)))
            }
        }
        else {
            var parameter = ""
            var k = 0
            for eachCategory in 0...categories.count-1 {
                parameter += "&category[\(k)]=\(categories[eachCategory])"
                k += 1
            }
            print(parameter)
            print(Constants.Methods.url+Constants.Methods.stories+"?page=\(page)"+parameter)
            Alamofire.request(.GET,Constants.Methods.url+Constants.Methods.stories+"?page=\(page)"+parameter).responseJSON {
                completionHandler(sendValues(JSON($0.result.value!)))
            }
            
        }
    }
    class func sendValues(json:JSON) -> [Story] {
        print(json)
        var stories = [Story]()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        for story in json["data"].array! {
            let date = dateFormatter.dateFromString(story["published_at"].string!)!
            stories.append(Story(title: story["title"].string!, description: story["description"].string!, article_link: story["article_link"].string!, thumbnail_url: story["thumbnail_url"].string!, publishedAt: date))
        }
        return stories
    }
    
    
    class func fetchCategories(completionHandler: [Category] -> Void){
        Alamofire.request(.GET, Constants.Methods.url + Constants.Methods.categories).responseJSON { response in
            print (response.result.value!)
            let json = JSON(response.result.value!)
            var categories = [Category]()
            for category in json.array! {
                categories.append(Category(id: category["id"].int!, title: category["title"].string!))
            }
            completionHandler(categories)
        }
    }
}
