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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
