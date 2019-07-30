//
//  ForumCellViewModel.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/7/30.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import Foundation
import UIKit


class ForumCellViewModel : ForumCellViewModelPresenter {
    var title:String
    var detail:String
    var replyCount:String
    var image_right:UIImage
    var thumbnail_image:UIImage
    
    init(forumArticle :ForumArticle){
        title = forumArticle.title
        detail = forumArticle.detail
        replyCount = forumArticle.replyCount
        image_right = UIImage(named: forumArticle.image_right)!.withRenderingMode(.alwaysTemplate)
        thumbnail_image = UIImage(named: forumArticle.thumbnail_image)!
    }
    
    func updateTitleLable(label:UILabel){
        label.text = title
    }
    func updateDetailLable(label:UILabel){
        label.text = detail
    }
    func updateReplyCountLable(lable:UILabel){
        lable.text = replyCount
    }
    func updateImageRight(imageView:UIImageView){
        imageView.image = image_right
    }
    func updateThumbnailImage(imageView:UIImageView){
        imageView.image = thumbnail_image
    }
}

protocol ForumCellViewModelPresenter {
    var title:String{get}
    var detail:String{get}
    var replyCount:String{get}
    var image_right:UIImage{get}
    var thumbnail_image:UIImage{get}
    
    func updateTitleLable(label:UILabel)
    func updateDetailLable(label:UILabel)
    func updateReplyCountLable(lable:UILabel)
    func updateImageRight(imageView:UIImageView)
    func updateThumbnailImage(imageView:UIImageView)
}
