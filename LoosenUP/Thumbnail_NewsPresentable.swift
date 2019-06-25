//
//  Thumbnail_NewsPresentable.swift
//  FocusUp
//
//  Created by 黃麒安 on 2016/2/29.
//  Copyright © 2016年 黃麒安. All rights reserved.
//

import Foundation
import UIKit



protocol Thumbnail_NewsPresentable{
    
    var thumbnail_image : UIImage {get}
    
    func updateImageView(imageview:UIImageView)
}

extension Thumbnail_NewsPresentable{
    
    var thumbnail_image : UIImage{
        return UIImage(named: "TiredIcon")!
    }
    
    func updateImageView(imageview:UIImageView){
        imageview.image = thumbnail_image
    }
    
}

