//
//  GalleryCollectionCell.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/13.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import UIKit

class GalleryCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image_Url: NSURL!
    var observer: NSKeyValueObservation?
    
    var size:CGSize!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Setting.shared.addObserver(self, forKeyPath: "themeType", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath! == "themeType"{
            self.addborder(color: Setting.shared.mainColor().cgColor, height: 1.0)
            self.tintColor = Setting.shared.mainColor()
        }
    }
    
    deinit {
        Setting.shared.removeObserver(self, forKeyPath: "themeType")
    }
}
