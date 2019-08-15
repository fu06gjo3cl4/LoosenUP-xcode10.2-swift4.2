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
    @IBOutlet weak var avatar_imageUrl: UIImageView!{
        didSet{
            let imageViewTap = UITapGestureRecognizer(target: self, action: #selector(self.imageViewDidTap))
            avatar_imageUrl.addGestureRecognizer(imageViewTap)
            avatar_imageUrl.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var btn_Like: UIButton!
    @IBOutlet weak var detailView: UIView!  //
    
    @IBOutlet weak var galleryCollectionView: GalleryCollectionView!
    
    @IBAction func likeBtnTouchUp(_ sender: Any) {
        
        if btn_Like.isSelected {
            // set deselected
            btn_Like.isSelected = false
            presenter?.isLikeOrNot = btn_Like.isSelected
            btn_Like.setImage(UIImage(named: "icon1"), for: .normal)
            btn_Like.setTitleColor(UIColor.lightGray, for: .normal)
            
            self.detailView.isHidden = true
        } else {
            // set selected
            btn_Like.isSelected = true
            presenter?.isLikeOrNot = btn_Like.isSelected
            btn_Like.tintColor = Setting.shared.mainColor()
            btn_Like.setImage(UIImage(named: "icon1")?.withRenderingMode(.alwaysTemplate), for: .selected)
            btn_Like.setTitleColor(Setting.shared.mainColor(), for: .selected)
            
            self.detailView.isHidden = false
        }
    }
    
    var observers = [NSKeyValueObservation]()
    
    weak var presenter: DynamicMessageCellViewModelPresenter?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateWithPresenter(){
        presenter!.updateIdLabel(label: lb_id)
        presenter!.updateTitleLabel(label: lb_title)
        presenter!.updateBodyLabel(label: lb_body)
        presenter!.updateUserIdLabel(label: lb_userId)
        presenter!.updateLikeBtn(btn: btn_Like)
        presenter!.updateAvatarImage(imageView: avatar_imageUrl)
        presenter!.updateCollactionView(collectionView: galleryCollectionView)
        presenter!.bindingValueWithVM(tableCell: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func imageViewDidTap(){
        print("imageViewDidTap")
        
        if let topController = UIApplication.topViewController(){
            print(topController)
            let viewcontroller = UIViewController()
            viewcontroller.title = "new page"
            viewcontroller.view.backgroundColor = UIColor.white
            topController.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
}

