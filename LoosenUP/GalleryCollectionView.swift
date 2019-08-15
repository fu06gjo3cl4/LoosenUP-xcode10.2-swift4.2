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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isScrollEnabled = false
        
    }
    
    func setHeight(){
        
        let height: CGFloat!
        let width = Const.Screen_Width/5
        if image_Urls.count % 5 != 0{
            height = CGFloat(((image_Urls.count/5)+1))*width
        }else{
            height = CGFloat((image_Urls.count/5))*width
        }
        
        for constraint in self.constraints {
            if constraint.identifier == "GalleryCollectionView.Height" {
                constraint.constant = height
            }
        }
        
    }
    
}


extension GalleryCollectionView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image_Urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let galleryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionCell", for: indexPath) as! GalleryCollectionCell
        galleryCell.addborder(view: galleryCell, color: Setting.shared.mainColor().cgColor, height: 1)
        
        print(indexPath.row)
        let image_Url = NSURL(string: image_Urls[indexPath.row])
        
        galleryCell.image_Url = image_Url // For recycled cells' late image loads.
        if let image = image_Url?.cachedImage { //抓過了 -> 直接顯示
            galleryCell.imageView.image = image
            galleryCell.imageView.alpha = 1
        } else { //沒抓過 ->下載圖片
            galleryCell.imageView.alpha = 0
            // 下載圖片
            image_Url?.fetchImage { image in
                // Check the cell hasn't recycled while loading.
                if galleryCell.image_Url == image_Url {
                    galleryCell.imageView.image = image
                    UIView.animate(withDuration: 0.3) {
                        galleryCell.imageView.alpha = 1
                    }
                }
            }
        }
        
        return galleryCell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (self.frame.width-20)/5, height: (self.frame.width-15)/5)
        return size
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
