//
//  NewsTableViewCell.swift
//  FocusUp
//
//  Created by 黃麒安 on 2016/2/21.
//  Copyright © 2016年 黃麒安. All rights reserved.
//

import UIKit

typealias NewsCellPresenter = Title_NewsPresentable & Datetime_NewsPresentable & Detail_btn_NewsPresentable & Thumbnail_NewsPresentable

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var btn_Detail: UIButton!
    @IBOutlet weak var lb_Datetime: UILabel!
    @IBOutlet weak var lb_Title: UILabel!
    
    func updateWithPresenter(presenter: NewsCellPresenter){
        presenter.updateTitleLable(label: lb_Title)
        presenter.updatedatetimeLable(label: lb_Datetime)
        presenter.updateImageView(imageview: imageview)
        presenter.updatedetailButton(button: btn_Detail)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
