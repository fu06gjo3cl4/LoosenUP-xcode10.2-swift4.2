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
    var avatarHeight:CGFloat = 0
    var galleryHeight:CGFloat = 0
    var gallerySizes:[CGSize] = [CGSize]()
    var galleryRects:[CGRect] = [CGRect]()
    var layoutType:LayoutType = .horizontal_1
    let group = DispatchGroup()
    let group_Gallery = DispatchGroup()
    
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
    
    func calculateCellHeight(callback:@escaping ()->() = { print("default func")}){
        
        var height:CGFloat = 60+40
        
        let string = self.body
        let labelHeight = string.heightWithConstrainedWidth(width: Const.Screen_Width, font: UIFont.systemFont(ofSize: 17.0))
        print(labelHeight)
        height += labelHeight+10
        
        let bottomLineHeight: CGFloat = 10
        height += bottomLineHeight

        if likeCount>0 {
            height += 40
            
        }
        
        
        group.enter()
        if !(image_Urls[0]=="") {
//            let multiple:CGFloat = CGFloat((image_Urls.count/5)+1)
//            let baseNum:CGFloat = CGFloat((Const.Screen_Size.width)/5)
//            height += (multiple*baseNum+10)
            
            //單張：獨自計算全部顯示的高度
            //多張：計算全部顯示所需的高度，且最大高度＝螢幕寬度
            if image_Urls.count == 1 {
                let image_Url = NSURL(string: image_Urls[0])
                if let image = image_Url?.cachedImage { //抓過了 -> 直接顯示
                    galleryHeight = image.size.height*(Const.Screen_Width/image.size.width)
                    height += galleryHeight
                    self.group.leave()
                } else { //沒抓過 ->下載圖片
                    image_Url?.fetchImage { image in
                        self.galleryHeight = image.size.height*(Const.Screen_Width/image.size.width)
                        height += self.galleryHeight
                        self.group.leave()
                    }
                }
            }else{
                
                for i in 0..<image_Urls.count{
                    group_Gallery.enter()
                    cacheAndCalculatePicHeight(imageUrl: image_Urls[i])
                }
                
                group_Gallery.notify(queue: .main){
                    if self.galleryHeight<Const.Screen_Width{
                        //顯示計算高度
                        height += self.galleryHeight
                        self.group.leave()
                    }else{
                        //以螢幕寬度作為最大高度
                        height += Const.Screen_Width
                        self.group.leave()
                    }
                }
            }
            
        }else{
            group.leave()
        }
        
        
        
        
        group.enter()
        if !(avatar_imageUrl=="") {
            //計算圖片應該顯示的高度
            let image_Url = NSURL(string: avatar_imageUrl)
            if let image = image_Url?.cachedImage { //抓過了 -> 直接顯示
                avatarHeight = image.size.height*(Const.Screen_Width/image.size.width)
//                height += self.avatarHeight
                group.leave()
            } else { //沒抓過 ->下載圖片
                image_Url?.fetchImage { image in
                    self.avatarHeight = image.size.height*(Const.Screen_Width/image.size.width)
//                    height += self.avatarHeight
                    self.group.leave()
                }
            }
        }else{
            group.leave()
        }
        
        group.notify(queue: .main){
            print(height)
            self.cellHeight = height
            callback()
            
            // 臨時解
            let vc = DynamicMessageViewController.shared.viewControllers[DynamicMessageViewController.shared.swipeMenuView.currentIndex] as! ContainerOfDynamicMessageViewController
            if !vc.isInitData {
                GCDService.q_cellsPreload.leave()
            }
        }
        
    }
    
    func cacheAndCalculatePicHeight(imageUrl: String,callback: ()->()={ print("default")}){
        let image_Url = NSURL(string: imageUrl)
        if let image = image_Url?.cachedImage { //抓過了 -> 直接顯示
            galleryHeight += image.size.height*(Const.Screen_Width/image.size.width)
            group_Gallery.leave()
        } else { //沒抓過 ->下載圖片
            image_Url?.fetchImage { image in
                self.galleryHeight += image.size.height*(Const.Screen_Width/image.size.width)
                self.group_Gallery.leave()
            }
        }
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
            imageView.isHidden = true
//            imageView.isHidden = false
            
            let image_Url = NSURL(string: avatar_imageUrl)
            if let image = image_Url?.cachedImage { //抓過了 -> 直接顯示
                imageView.image = image//.circleMasked
                imageView.alpha = 1
                
                for constraint in imageView.constraints {
                    if constraint.identifier == "avatarHeight" {
                        constraint.constant = self.avatarHeight
                    }
                }
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
    
    func updateGalleryView(view: UIView,imageviews_1: UIImageView,imageviews_2: UIImageView,imageviews_3: UIImageView,imageviews_4: UIImageView,imageviews_5: UIImageView){
        
        if image_Urls[0] == "" {
            view.isHidden = true
        }else{
            view.isHidden = false
        }
        
        let height:CGFloat!
        if galleryHeight<Const.Screen_Width{
            height = galleryHeight
        }else{
            height = Const.Screen_Width
        }
        for constraint in view.constraints {
            if constraint.identifier == "HeightOfGalleryView" {
                constraint.constant = height//galleryHeight
            }
        }
        
        //先單純根據圖片數量決定size
        if image_Urls.count>5{
            layoutType = .horizontal_6plus
            let rects = [CGRect(x: 0, y: 0, width: (Const.Screen_Width/2-2), height: (Const.Screen_Width/2-2)),
                        CGRect(x: 0, y: (Const.Screen_Width/2+2), width: (Const.Screen_Width/2-2), height: (Const.Screen_Width/2-2)),
                        CGRect(x: (Const.Screen_Width/2+2), y: 0, width: (Const.Screen_Width/2-2), height: (Const.Screen_Width/3-2)),
                        CGRect(x: (Const.Screen_Width/2+2), y: (Const.Screen_Width/3+2), width: (Const.Screen_Width/2-2), height: (Const.Screen_Width/3-2)),
                        CGRect(x: (Const.Screen_Width/2+2), y: (Const.Screen_Width/3+2)*2, width: (Const.Screen_Width/2-2), height: (Const.Screen_Width/3-2))]
            self.galleryRects = rects
        }else if image_Urls.count==5{
            layoutType = .horizontal_5
            let rects = [CGRect(x: 0, y: 0, width: (Const.Screen_Width/2-2), height: (Const.Screen_Width/2-2)),
                         CGRect(x: 0, y: (Const.Screen_Width/2+2), width: (Const.Screen_Width/2-2), height: (Const.Screen_Width/2-2)),
                         CGRect(x: (Const.Screen_Width/2+2), y: 0, width: (Const.Screen_Width/2-2), height: (Const.Screen_Width/3-2)),
                         CGRect(x: (Const.Screen_Width/2+2), y: (Const.Screen_Width/3+2), width: (Const.Screen_Width/2-2), height: (Const.Screen_Width/3-2)),
                         CGRect(x: (Const.Screen_Width/2+2), y: (Const.Screen_Width/3+2)*2, width: (Const.Screen_Width/2-2), height: (Const.Screen_Width/3-2))]
            self.galleryRects = rects
        }else if image_Urls.count==4{
            layoutType = .horizontal_4
            let rects = [CGRect(x: 0, y: 0, width: (Const.Screen_Width), height: Const.Screen_Width*2/3),
                         CGRect(x: 0, y: Const.Screen_Width*2/3+2, width: (Const.Screen_Width/3-2), height: Const.Screen_Width/3),
                         CGRect(x: (Const.Screen_Width/3+2), y: Const.Screen_Width*2/3+4, width: (Const.Screen_Width/3-2), height: Const.Screen_Width/3),
                         CGRect(x: (Const.Screen_Width/3+2)*2, y: Const.Screen_Width*2/3+4, width: (Const.Screen_Width/3-2), height: Const.Screen_Width/3)]
            self.galleryRects = rects
        }else if image_Urls.count==3{
            layoutType = .horizontal_3
            let rects = [CGRect(x: 0, y: 0, width: Const.Screen_Width, height: Const.Screen_Width*2/3-2),
                         CGRect(x: 0, y: Const.Screen_Width*2/3+2, width: (Const.Screen_Width/2-2), height: Const.Screen_Width/3-2),
                         CGRect(x: Const.Screen_Width/2+2, y: Const.Screen_Width*2/3+2, width: (Const.Screen_Width/2-2), height: Const.Screen_Width/3-2)]
            self.galleryRects = rects
        }else if image_Urls.count==2{
            layoutType = .horizontal_2
            let rects = [CGRect(x: 0, y: 0, width: (Const.Screen_Width), height: Const.Screen_Width/2-2),
                         CGRect(x: 0, y: Const.Screen_Width/2+2, width: (Const.Screen_Width), height: Const.Screen_Width/2-2)]
            self.galleryRects = rects
        }else if image_Urls.count==1{
            layoutType = .horizontal_1
            self.galleryRects = [CGRect(x: 0, y: 0, width: Const.Screen_Width, height: Const.Screen_Width/2-2)]
        }
        
        switch layoutType {
        case .horizontal_6plus:
            imageviews_1.frame = galleryRects[0]
            imageviews_1.contentMode = .scaleAspectFill
            imageviews_1.clipsToBounds = true
            imageviews_1.isHidden = false
            if let image = NSURL(string: image_Urls[0])?.cachedImage {
                imageviews_1.image = image
                imageviews_1.alpha = 1
            }
            
            imageviews_2.frame = galleryRects[1]
            imageviews_2.contentMode = .scaleAspectFill
            imageviews_2.clipsToBounds = true
            imageviews_2.isHidden = false
            if let image = NSURL(string: image_Urls[1])?.cachedImage {
                imageviews_2.image = image
                imageviews_2.alpha = 1
            }
            
            imageviews_3.frame = galleryRects[2]
            imageviews_3.contentMode = .scaleAspectFill
            imageviews_3.clipsToBounds = true
            imageviews_3.isHidden = false
            if let image = NSURL(string: image_Urls[2])?.cachedImage {
                imageviews_3.image = image
                imageviews_3.alpha = 1
            }
            
            imageviews_4.frame = galleryRects[3]
            imageviews_4.contentMode = .scaleAspectFill
            imageviews_4.clipsToBounds = true
            imageviews_4.isHidden = false
            if let image = NSURL(string: image_Urls[3])?.cachedImage {
                imageviews_4.image = image
                imageviews_4.alpha = 1
            }
            
            imageviews_5.frame = galleryRects[4]
            imageviews_5.contentMode = .scaleAspectFill
            imageviews_5.clipsToBounds = true
            imageviews_5.isHidden = false
            if let image = NSURL(string: image_Urls[4])?.cachedImage {
                imageviews_5.image = image
                imageviews_5.alpha = 1
            }
        case .horizontal_5:
            imageviews_1.frame = galleryRects[0]
            imageviews_1.contentMode = .scaleAspectFill
            imageviews_1.clipsToBounds = true
            imageviews_1.isHidden = false
            if let image = NSURL(string: image_Urls[0])?.cachedImage {
                imageviews_1.image = image
                imageviews_1.alpha = 1
            }
            
            imageviews_2.frame = galleryRects[1]
            imageviews_2.contentMode = .scaleAspectFill
            imageviews_2.clipsToBounds = true
            imageviews_2.isHidden = false
            if let image = NSURL(string: image_Urls[1])?.cachedImage {
                imageviews_2.image = image
                imageviews_2.alpha = 1
            }
            
            imageviews_3.frame = galleryRects[2]
            imageviews_3.contentMode = .scaleAspectFill
            imageviews_3.clipsToBounds = true
            imageviews_3.isHidden = false
            if let image = NSURL(string: image_Urls[2])?.cachedImage {
                imageviews_3.image = image
                imageviews_3.alpha = 1
            }
            
            imageviews_4.frame = galleryRects[3]
            imageviews_4.contentMode = .scaleAspectFill
            imageviews_4.clipsToBounds = true
            imageviews_4.isHidden = false
            if let image = NSURL(string: image_Urls[3])?.cachedImage {
                imageviews_4.image = image
                imageviews_4.alpha = 1
            }
            
            imageviews_5.frame = galleryRects[4]
            imageviews_5.contentMode = .scaleAspectFill
            imageviews_5.clipsToBounds = true
            imageviews_5.isHidden = false
            if let image = NSURL(string: image_Urls[4])?.cachedImage {
                imageviews_5.image = image
                imageviews_5.alpha = 1
            }
        case .horizontal_4:
            imageviews_1.frame = galleryRects[0]
            imageviews_1.contentMode = .scaleAspectFill
            imageviews_1.clipsToBounds = true
            imageviews_1.isHidden = false
            if let image = NSURL(string: image_Urls[0])?.cachedImage {
                imageviews_1.image = image
                imageviews_1.alpha = 1
            }
            
            imageviews_2.frame = galleryRects[1]
            imageviews_2.contentMode = .scaleAspectFill
            imageviews_2.clipsToBounds = true
            imageviews_2.isHidden = false
            if let image = NSURL(string: image_Urls[1])?.cachedImage {
                imageviews_2.image = image
                imageviews_2.alpha = 1
            }
            
            imageviews_3.frame = galleryRects[2]
            imageviews_3.contentMode = .scaleAspectFill
            imageviews_3.clipsToBounds = true
            imageviews_3.isHidden = false
            if let image = NSURL(string: image_Urls[2])?.cachedImage {
                imageviews_3.image = image
                imageviews_3.alpha = 1
            }
            
            imageviews_4.frame = galleryRects[3]
            imageviews_4.contentMode = .scaleAspectFill
            imageviews_4.clipsToBounds = true
            imageviews_4.isHidden = false
            if let image = NSURL(string: image_Urls[3])?.cachedImage {
                imageviews_4.image = image
                imageviews_4.alpha = 1
            }
            
            imageviews_5.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            imageviews_5.isHidden = true
        case .horizontal_3:
            imageviews_1.frame = galleryRects[0]
            imageviews_1.contentMode = .scaleAspectFill
            imageviews_1.clipsToBounds = true
            imageviews_1.isHidden = false
            if let image = NSURL(string: image_Urls[0])?.cachedImage {
                imageviews_1.image = image
                imageviews_1.alpha = 1
            }
            
            imageviews_2.frame = galleryRects[1]
            imageviews_2.contentMode = .scaleAspectFill
            imageviews_2.clipsToBounds = true
            imageviews_2.isHidden = false
            if let image = NSURL(string: image_Urls[1])?.cachedImage {
                imageviews_2.image = image
                imageviews_2.alpha = 1
            }
            
            imageviews_3.frame = galleryRects[2]
            imageviews_3.contentMode = .scaleAspectFill
            imageviews_3.clipsToBounds = true
            imageviews_3.isHidden = false
            if let image = NSURL(string: image_Urls[2])?.cachedImage {
                imageviews_3.image = image
                imageviews_3.alpha = 1
            }
            
            imageviews_4.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            imageviews_4.isHidden = true
            
            imageviews_5.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            imageviews_5.isHidden = true
        case .horizontal_2:
            imageviews_1.frame = galleryRects[0]
            imageviews_1.contentMode = .scaleAspectFill
            imageviews_1.clipsToBounds = true
            imageviews_1.isHidden = false
            if let image = NSURL(string: image_Urls[0])?.cachedImage {
                imageviews_1.image = image
                imageviews_1.alpha = 1
            }
            
            imageviews_2.frame = galleryRects[1]
            imageviews_2.contentMode = .scaleAspectFill
            imageviews_2.clipsToBounds = true
            imageviews_2.isHidden = false
            if let image = NSURL(string: image_Urls[1])?.cachedImage {
                imageviews_2.image = image
                imageviews_2.alpha = 1
            }
            
            imageviews_3.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            imageviews_3.isHidden = true
            
            imageviews_4.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            imageviews_4.isHidden = true
            
            imageviews_5.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            imageviews_5.isHidden = true
        case .horizontal_1:
            imageviews_1.frame = galleryRects[0]
            print(galleryRects[0].size.height)
            print(galleryRects[0].size.width)
            imageviews_1.contentMode = .scaleAspectFill
            imageviews_1.clipsToBounds = true
            imageviews_1.isHidden = false
            if let image = NSURL(string: image_Urls[0])?.cachedImage {
                imageviews_1.image = image
                imageviews_1.alpha = 1
            }
            
            imageviews_2.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            imageviews_2.isHidden = true
            
            imageviews_3.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            imageviews_3.isHidden = true
            
            imageviews_4.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            imageviews_4.isHidden = true
            
            imageviews_5.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            imageviews_5.isHidden = true
        default:
            print("switch deault")
        }
        
    }
    func updateCollactionView(collectionView:GalleryCollectionView){
        
        if image_Urls.count <= 1 && image_Urls[0] == ""{
            collectionView.isHidden = true
        }else{
            collectionView.isHidden = true
//            collectionView.isHidden = false
            collectionView.image_Urls = image_Urls
            collectionView.delegate = collectionView
            collectionView.dataSource = collectionView
            let galleryCell = UINib(nibName: "GalleryCollectionCell", bundle: nil)
            collectionView.register(galleryCell, forCellWithReuseIdentifier: "GalleryCollectionCell")
            if galleryHeight<Const.Screen_Width{
                collectionView.setHeight(height: galleryHeight)
            }else{
                collectionView.setHeight(height: Const.Screen_Width)
            }
            collectionView.layoutSetting()
            // 建立 UICollectionViewFlowLayout
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
            layout.minimumLineSpacing = 3
            layout.minimumInteritemSpacing = 0
//            layout.scrollDirection = .horizontal
            layout.scrollDirection = .vertical
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
    var image_Urls:[String]{get}
    var isLikeOrNot:Bool{get set}
    var likeCount:Int{get set}
    var galleryRects:[CGRect]{get}
    var layoutType:LayoutType{get}
    
    func updateIdLabel(label:UILabel)
    func updateTitleLabel(label:UILabel)
    func updateBodyLabel(label:UILabel)
    func updateUserIdLabel(label:UILabel)
    func updateLikeBtn(btn:UIButton)
    func updateDetailView(view: UIView)
    func updateAvatarImage(imageView:UIImageView)
    func updateGalleryView(view: UIView,imageviews_1: UIImageView,imageviews_2: UIImageView,imageviews_3: UIImageView,imageviews_4: UIImageView,imageviews_5: UIImageView)
    func updateCollactionView(collectionView:GalleryCollectionView)
    func bindingValueWithVM(tableCell: DynamicMessageTableCell)
    func calculateCellHeight(callback:@escaping ()->())
}

enum LayoutType{
    case horizontal_1
    case horizontal_2
    case horizontal_3
    case horizontal_4
    case horizontal_5
    case horizontal_6plus
    // height < screen width
    case horizontal_stack_1
    case horizontal_stack_2
    case horizontal_stack_3
    case horizontal_stack_4plus
    
    case vertical_1
    case vertical_2
    case vertical_3
    case vertical_4
    case vertical_5
    case vertical_6plus
}
