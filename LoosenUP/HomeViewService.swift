//
//  HomeViewService.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/6.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HomeViewService {
    
    //網路請求區塊
    static func GetNewsList(amount : String,callback:@escaping ([News])->())->(){
        
        var NewsList : [News] = [News]()
        
        Alamofire.request(GetUrl.Url + ApiList.GetNewsList + amount)
            .responseJSON { response in
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                    
                    for i in 0 ..< json.count {
                        var news = News()
                        news.title = json[i]["NewsTitle"].stringValue
                        news.datetime = json[i]["NewsTime"].stringValue
                        news.content = json[i]["NewsContent"].stringValue
                        
                        NewsList.append(news)
                    }
                    callback(NewsList)
                }
        }
        
    }
    
    
    
}
