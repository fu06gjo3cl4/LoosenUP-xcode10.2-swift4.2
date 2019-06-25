//
//  NewsViewModel.swift
//  FocusUp
//
//  Created by 黃麒安 on 2016/2/29.
//  Copyright © 2016年 黃麒安. All rights reserved.
//

import Foundation
import UIKit


struct NewsCellViewModel : NewsCellPresenter {
    var title:String
    var datetime:String
    var detail_btn_image:UIImage
    var thumbnail_image:UIImage
    
    init(news:News){
        title = news.title
        datetime = news.datetime
        detail_btn_image = UIImage(named: news.detail_btn_image)!
        thumbnail_image = UIImage(named: news.thumbnail_image)!
        
    }
    
}
