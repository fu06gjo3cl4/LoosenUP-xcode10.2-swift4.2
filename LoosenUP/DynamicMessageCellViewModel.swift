//
//  DynamicMessageCellViewModel.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/12.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import Foundation
import UIKit

class DynamicMessageCellViewModel : DynamicMessageCellViewModelPresenter {
    var id:String = "20"
    var title:String = "default"
    var body:String = "default"
    var userId:String = "default"
    var avatar_imageUrl:String = "default"
    var image_Urls:[String] = [String]()
    
    var numberOfImage:Int = 1
    
    init(dynamicMessage :DynamicMessage){
        id = dynamicMessage.id
        title = dynamicMessage.title
        body = dynamicMessage.body
        userId = dynamicMessage.userId
        avatar_imageUrl = dynamicMessage.avatar
        image_Urls = dynamicMessage.image_Urls
    }
    
    func updateIdLabel(label:UILabel){
        label.text = id
    }
    func updateTitleLabel(label:UILabel){
        label.text = title
    }
    func updateBodyLabel(label:UILabel){
        label.text = body
    }
    func updateUserIdLabel(label:UILabel){
        label.text = userId
    }
    func updateAvatarImage(imageView:UIImageView){
        imageView.downloadedForCircleMasked(from: avatar_imageUrl)
    }
    func updateCollactionView(collectionView:GalleryCollectionView){
        collectionView.image_Urls = image_Urls
        collectionView.delegate = collectionView
        collectionView.dataSource = collectionView
        let rankCell = UINib(nibName: "RankingCollectionCell", bundle: nil)
        collectionView.register(rankCell, forCellWithReuseIdentifier: "RankingCollectionCell")
        let galleryCell = UINib(nibName: "GalleryCollectionCell", bundle: nil)
        collectionView.register(galleryCell, forCellWithReuseIdentifier: "GalleryCollectionCell")
        collectionView.setHeight()
    }
    
}

protocol DynamicMessageCellViewModelPresenter {
    var id:String{get}
    var title:String{get}
    var body:String{get}
    var userId:String{get}
    var avatar_imageUrl:String{get}
    
    func updateIdLabel(label:UILabel)
    func updateTitleLabel(label:UILabel)
    func updateBodyLabel(label:UILabel)
    func updateUserIdLabel(label:UILabel)
    func updateAvatarImage(imageView:UIImageView)
    func updateCollactionView(collectionView:GalleryCollectionView)
}
