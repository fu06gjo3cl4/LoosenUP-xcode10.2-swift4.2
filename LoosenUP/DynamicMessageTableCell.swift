//
//  DynamicMessageTableCell.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/12.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import UIKit

class DynamicMessageTableCell: UITableViewCell {
    
    @IBOutlet weak var lb_id: UILabel!
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var lb_body: UILabel!
    @IBOutlet weak var lb_userId: UILabel!
    @IBOutlet weak var avatar_imageUrl: UIImageView!
    
    @IBOutlet weak var galleryCollectionView: GalleryCollectionView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateWithPresenter(presenter: DynamicMessageCellViewModelPresenter){
        presenter.updateIdLabel(label: lb_id)
        presenter.updateTitleLabel(label: lb_title)
        presenter.updateBodyLabel(label: lb_body)
        presenter.updateUserIdLabel(label: lb_userId)
        presenter.updateAvatarImage(imageView: avatar_imageUrl)
        presenter.updateCollactionView(collectionView: galleryCollectionView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//protocol DynamicMessageCellViewModelPresenter {
//    var id:String{get}
//    var title:String{get}
//    var body:String{get}
//    var userId:String{get}
//    var avatar_imageUrl:String{get}
//
//    func updateIdLable(label:UILabel)
//    func updateTitleLable(label:UILabel)
//    func updateBodyLable(label:UILabel)
//    func updateUserIdLable(lable:UILabel)
//    func updateAvatarImage(imageView:UIImageView)
//}
