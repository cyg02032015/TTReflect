//
//  ViewController.swift
//  TTReflect
//
//  Created by 谢许峰 on 16/1/10.
//  Copyright © 2016年 tifatsubasa. All rights reserved.
//

import UIKit
import AFNetworking
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let home = Reflect.modelArray("Home", type: Item.self)
        
        let bookUrl = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("book", ofType: nil)!)
        let bookData = NSData(contentsOfURL: bookUrl)
        
        let castUrl = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("casts", ofType: nil)!)
        let castsData = NSData(contentsOfURL: castUrl)
//        print(bookData)
//        let book = Book()
        //        book.replacePropertyName = []
        let casts = Reflect.modelArray(castsData, type: Cast.self)
        print(casts)
        
        let book = Reflect.model(bookData, type: Book.self)
        NSLog("end")
        
        let tags = book?.tags
        tags?.forEach({ (tag: Tag) -> () in
            print(tag.title)
        })
        self.useAlamofire()
        self.useAFNetworking()
    }
    
    func useAlamofire() {
        Alamofire.request(.GET, "https://api.douban.com/v2/movie/subject/1764796", parameters: nil)
            .response { request, response, data, error in
                let movie = Reflect.model(data, type: Movie.self)
                print(movie)
        }
    }
    
    func useAFNetworking() {
        let manager = AFHTTPRequestOperationManager()
        manager.GET("https://api.douban.com/v2/movie/subject/1764796", parameters: nil, success: { (operation, responseData) -> Void in
            let movie = Reflect.model(responseData, type: Movie.self)
            print(movie)
            }, failure: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

