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
    var images = [UIImage]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isScrollEnabled = false
        
    }
    
    func setHeight(){
        
        switch image_Urls.count {
        case 0:
            for constraint in self.constraints {
                if constraint.identifier == "GalleryCollectionView.Height" {
                    constraint.constant = 0
                }
            }
        case 1:
            if image_Urls[0] != ""{
                for constraint in self.constraints {
                    if constraint.identifier == "GalleryCollectionView.Height" {
                        constraint.constant = 200
                    }
                }
            }else{
                for constraint in self.constraints {
                    if constraint.identifier == "GalleryCollectionView.Height" {
                        constraint.constant = 0
                    }
                }
            }
        case 2:
            for constraint in self.constraints {
                if constraint.identifier == "GalleryCollectionView.Height" {
                    constraint.constant = 400
                }
            }
        case 0:
            for constraint in self.constraints {
                if constraint.identifier == "GalleryCollectionView.Height" {
                    constraint.constant = 600
                }
            }
        default:
            for constraint in self.constraints {
                if constraint.identifier == "GalleryCollectionView.Height" {
                    constraint.constant = 1000
                }
            }
        }
        
        
//        for constraint in self.constraints {
//            if constraint.identifier == "GalleryCollectionView.Height" {
//                constraint.constant = 1000
//            }
//        }
        
//        self.customView.collectionView.reloadData()
//        for constraint in self.customView.collectionView.constraints {
//            if constraint.identifier == "heightOfCollectionView" {
//                constraint.constant = self.customView.collectionView.collectionViewLayout.collectionViewContentSize.height
//            }
//        }
    }
    
}


extension GalleryCollectionView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image_Urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let galleryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionCell", for: indexPath) as! GalleryCollectionCell
        
//        if(!images.isEmpty){
//            galleryCell.imageView.image = images[indexPath.row]
//        }else{
//            galleryCell.imageView.downloaded(from: image_Urls[indexPath.row])
////            self.images.append()
//
//            images[0].images
//        }
        
        galleryCell.imageView.downloaded(from: image_Urls[indexPath.row])
        self.images.append(galleryCell.imageView.image!)
        
        return galleryCell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (Const.Screen_Width), height: 200)
//        let size = CGSize(width: (Const.Screen_Width)/CGFloat(image_Urls.count), height: (Const.Screen_Height)/CGFloat(image_Urls.count))
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select item at indexPath: \(indexPath.row)" )
        
        if let topController = UIApplication.topViewController(){
            print(topController)
            let viewcontroller = RankingDetailViewController()
            viewcontroller.ranking = indexPath.row
            topController.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
}
