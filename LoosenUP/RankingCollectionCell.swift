//
//  RankingCollectionCell.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/16.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit

class RankingCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var view_container: UIView!
    @IBOutlet weak var image_no: UIImageView!
    
    var test:String = "0"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.view_container.addborder(view: self.view_container, color: Setting.shared.mainColor().cgColor, height: 1.0)
        self.tintColor = Setting.shared.mainColor()
        Setting.shared.addObserver(self, forKeyPath: "themeType", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.view_container.addborder(view: self.view_container, color: Setting.shared.mainColor().cgColor, height: 1.0)
        
        self.tintColor = Setting.shared.mainColor()
        image_no.image = image_no.image?.withRenderingMode(.alwaysTemplate)
    }
    
    deinit {
        self.observationInfo = nil
    }

}
