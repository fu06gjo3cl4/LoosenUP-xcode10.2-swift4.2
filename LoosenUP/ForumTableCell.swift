//
//  ForumTableCell.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/22.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit

class ForumTableCell: UITableViewCell {
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var lb_detail: UILabel!
    @IBOutlet weak var image_right: UIImageView!
    @IBOutlet weak var lb_replyCount: UILabel!
    
    @IBOutlet weak var container_view: UIView!
    
    @IBOutlet weak var whiteRoundedView: UIView!{
        didSet{
            
            whiteRoundedView.addborder(view: whiteRoundedView, color: Const.white.cgColor, height: 1)
            whiteRoundedView.SetCornerRadius(view: whiteRoundedView, cornerRadius: 2.0)
            whiteRoundedView.addShadow(view: whiteRoundedView, color: Const.black.cgColor, width: -1, height: 1, radius: 2.0, opacity: 0.2)
            
        }
    }
//    var whiteRoundedView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        whiteRoundedView = UIView(frame: CGRect(x: 10, y: 8, width: Const.Screen_Width - 20, height: 100))
        
//        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
//        whiteRoundedView.layer.masksToBounds = false
        
//        whiteRoundedView.layer.cornerRadius = 2.0
//        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
//        whiteRoundedView.layer.shadowOpacity = 0.2
        
        
//        self.contentView.addSubview(whiteRoundedView)
//        self.contentView.sendSubviewToBack(whiteRoundedView)
        
        
        
        
//        container_view.addborder(view: container_view, color: Const.black.cgColor, height: 5.0)
//        container_view.setBackgroundColor(view: container_view, color: CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])!)
//        container_view.SetCornerRadius(view: container_view, cornerRadius: 2.0)
//        container_view.layer.masksToBounds = false
//        container_view.layer.shadowOffset = CGSize(width: -1, height: 1)
//        container_view.layer.shadowOpacity = 0.2
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
