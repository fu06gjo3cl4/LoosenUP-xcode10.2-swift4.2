//
//  DynamicMessageCellViewModel.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/12.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import Foundation
import UIKit

class DynamicMessageCellViewModel: NSObject, DynamicMessageCellViewModelPresenter {
    var id:String = "20"
    var title:String = "default"
    @objc dynamic var body:String = "default"
    var userId:String = "default"
    var avatar_imageUrl:String = "default"
    var image_Urls:[String] = [String]()
    var isLikeOrNot:Bool = false
    var likeCount:Int = 0
    
    var isNeedToReload:Bool = false  // numberOfImage:Int = 1   //?
    var cellIndex:IndexPath = IndexPath(row: 0, section: 0)
    var cellHeight:CGFloat = 0
    
    init(dynamicMessage :DynamicMessage){
        id = dynamicMessage.id
        title = dynamicMessage.title
        body = dynamicMessage.body
        userId = dynamicMessage.userId
        avatar_imageUrl = dynamicMessage.avatar
        image_Urls = dynamicMessage.image_Urls
        super.init()
        calculateCellHeight()
    }
    
    func calculateCellHeight(){
        var height:CGFloat = 60+40
        if likeCount>0 {
            height += 40
            
        }
        if !(image_Urls[0]=="") {
            let multiple:CGFloat = CGFloat((image_Urls.count/5)+1)
            let baseNum:CGFloat = CGFloat((Const.Screen_Size.width)/5)
            height += (multiple*baseNum+10)
        }
        if !(avatar_imageUrl=="") {
            height += 150
        }
        
        let string = self.body
        let labelHeight = string.heightWithConstrainedWidth(width: Const.Screen_Width, font: UIFont.systemFont(ofSize: 17.0))+10
        print(labelHeight)
        height += labelHeight
        
        let bottomLineHeight: CGFloat = 10
        height += bottomLineHeight
        
        self.cellHeight = height
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
    func updateLikeBtn(btn:UIButton){
        btn.isSelected = isLikeOrNot
        btn.tintColor = Setting.shared.mainColor()
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(UIImage(named: "icon1"), for: .normal)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        btn.setImage(UIImage(named: "icon1")?.withRenderingMode(.alwaysTemplate), for: .selected)
        btn.setTitleColor(Setting.shared.mainColor(), for: .selected)
        
    }
    func updateDetailView(view: UIView){
        
        if likeCount>0{
            view.isHidden = false
        }else{
            view.isHidden = true
        }
        
    }
    func updateAvatarImage(imageView:UIImageView){
        if avatar_imageUrl == ""{
            imageView.image = nil
            imageView.isHidden = true
        }else{
            imageView.isHidden = false
            
            let image_Url = NSURL(string: avatar_imageUrl)
            if let image = image_Url?.cachedImage { //抓過了 -> 直接顯示
                imageView.image = image//.circleMasked
                imageView.alpha = 1
            } else { //沒抓過 ->下載圖片
                imageView.alpha = 0
                // 下載圖片
                image_Url?.fetchImage { image in
                    // Check the cell hasn't recycled while loading.
                    imageView.image = image//.circleMasked
                    UIView.animate(withDuration: 0.3) {
                        imageView.alpha = 1
                    }
                }
            }
        }
        
    }
    func updateCollactionView(collectionView:GalleryCollectionView){
        
        if image_Urls.count <= 1 && image_Urls[0] == ""{
            collectionView.isHidden = true
        }else{
            collectionView.isHidden = false
            collectionView.image_Urls = image_Urls
            collectionView.delegate = collectionView
            collectionView.dataSource = collectionView
            let galleryCell = UINib(nibName: "GalleryCollectionCell", bundle: nil)
            collectionView.register(galleryCell, forCellWithReuseIdentifier: "GalleryCollectionCell")
            collectionView.setHeight()
            // 建立 UICollectionViewFlowLayout
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5);
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 0
            collectionView.collectionViewLayout = layout
        }
    }
    
    func bindingValueWithVM(tableCell: DynamicMessageTableCell){
        
        tableCell.observers.append(
            self.observe(\.body,options: [.new], changeHandler: {(self, change) in
                print(change)
                self.calculateCellHeight()
            })
        )
        
    }
    
}

protocol DynamicMessageCellViewModelPresenter: AnyObject {
    var id:String{get}
    var title:String{get}
    var body:String{get set}
    var userId:String{get}
    var avatar_imageUrl:String{get}
    var isLikeOrNot:Bool{get set}
    var likeCount:Int{get set}
    
    func updateIdLabel(label:UILabel)
    func updateTitleLabel(label:UILabel)
    func updateBodyLabel(label:UILabel)
    func updateUserIdLabel(label:UILabel)
    func updateLikeBtn(btn:UIButton)
    func updateDetailView(view: UIView)
    func updateAvatarImage(imageView:UIImageView)
    func updateCollactionView(collectionView:GalleryCollectionView)
    func bindingValueWithVM(tableCell: DynamicMessageTableCell)
    func calculateCellHeight()
}
