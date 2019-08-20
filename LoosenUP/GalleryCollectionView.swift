//
//  GalleryCollectionView.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/13.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import Foundation
import UIKit

class GalleryCollectionView: UICollectionView {
    
    var image_Urls: [String] = [String]()
    var cellCount: Int = 16
    var images = [UIImage?]()
    
    var layoutType:LayoutType = .horizontal_1
    var galleryHeight:CGFloat = 0
    var collectionViewHeight:CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isScrollEnabled = false
        
    }
    
    func setHeight(height: CGFloat){
        collectionViewHeight = height
        for constraint in self.constraints {
            if constraint.identifier == "GalleryCollectionView.Height" {
                constraint.constant = height
            }
        }
    }
    
    func layoutSetting(){
        
        for imageUrl in image_Urls{
            let image_Url = NSURL(string: imageUrl)
            if let image = image_Url?.cachedImage {
                galleryHeight += image.size.height*(Const.Screen_Width/image.size.width)
                images.append(image)
            }
        }
        
        if galleryHeight>Const.Screen_Width{
            //呈現版型
            
            if images.count>5{
                layoutType = .horizontal_6plus
            }else if images.count==5{
                layoutType = .horizontal_5
            }else if images.count==4{
                layoutType = .horizontal_4
            }else if images.count==3{
                layoutType = .horizontal_3
            }else if images.count==2{
                layoutType = .horizontal_2
            }else if images.count==1{
                layoutType = .horizontal_1
            }
            
//            layoutType =
            
//            if images.count>1{
//                for image in images{
//
//                }
//            }else{
//
//            }
        }else{
            //呈現版型
            
        }
        
    }
}


extension GalleryCollectionView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if image_Urls.count<5{
            return image_Urls.count
        }else{
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let galleryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionCell", for: indexPath) as! GalleryCollectionCell
        galleryCell.addborder(color: Setting.shared.mainColor().cgColor, height: 1)
        
        print(indexPath.row)
        let image_Url = NSURL(string: image_Urls[indexPath.row])
        
        galleryCell.image_Url = image_Url
        if let image = image_Url?.cachedImage { //抓過了 -> 直接顯示
            galleryCell.imageView.image = image
            galleryCell.imageView.alpha = 1
        }
        
        return galleryCell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch layoutType {
        case .horizontal_1:
            return CGSize(width: (Const.Screen_Width-2), height: Const.Screen_Width/2-2)
        case .horizontal_2:
            switch indexPath.row {
            case 0:
                return CGSize(width: (Const.Screen_Width-2), height: Const.Screen_Width/2-2)
            case 1:
                return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/2-2)
            default:
                return CGSize(width: 0, height: 0)
            }
        case .horizontal_3:
            switch indexPath.row {
            case 0:
                //image.size.height*(Const.Screen_Width/image.size.width)
                return CGSize(width: (Const.Screen_Width), height: Const.Screen_Width*2/3)
            case 1:
                return CGSize(width: (Const.Screen_Width/2), height: Const.Screen_Width/3)
            case 2:
                return CGSize(width: (Const.Screen_Width/2), height: Const.Screen_Width/3)
            default:
                return CGSize(width: 0, height: 0)
            }
        case .horizontal_4:
            switch indexPath.row {
            case 0:
                return CGSize(width: (Const.Screen_Width-2), height: Const.Screen_Width*2/3)
            case 1:
                return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/3-2)
            case 2:
                return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/3-2)
            case 3:
                return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/3-2)
            default:
                return CGSize(width: 0, height: 0)
            }
        case .horizontal_5:
            switch indexPath.row {
            case 0:
                return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/2-2)
            case 1:
                return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/2-2)
            case 2:
                return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/3-2)
            case 3:
                return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/3-2)
            case 4:
                return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/3-2)
            default:
                return CGSize(width: 0, height: 0)
            }
        case .horizontal_6plus:
            switch indexPath.row {
            case 0:
                return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/2-2)
            case 1:
                return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/2-2)
            case 2:
                return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/3-2)
            case 3:
                return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/3-2)
            case 4:
                return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/3-2)
            default:
                return CGSize(width: 0, height: 0)
            }
        default:
            return CGSize(width: 0, height: 0)
        }
        
        switch indexPath.row {
        case 0:
            return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/2-2)
        case 1:
            return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/2-2)
        case 2:
            return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/3-2)
        case 3:
            return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/3-2)
        case 4:
            return CGSize(width: (Const.Screen_Width/2-2), height: Const.Screen_Width/3-2)
        default:
            return CGSize(width: 0, height: 0)
        }
        
        
        
//        let size = CGSize(width: Const.Screen_Width, height: (images[indexPath.row]?.size.height)!*(Const.Screen_Width/images[indexPath.row]!.size.width))
//        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select item at indexPath: \(indexPath.row)" )
        
        if let topController = UIApplication.topViewController(){
            print(topController)
            let viewcontroller = UIViewController()
            viewcontroller.title = "new page"
            viewcontroller.view.backgroundColor = UIColor.white
            topController.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
    
    
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



