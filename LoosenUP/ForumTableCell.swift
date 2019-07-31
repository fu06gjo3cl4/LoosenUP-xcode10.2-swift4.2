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
    
    @IBOutlet weak var whiteRoundedView: UIView!{
        didSet{
            whiteRoundedView.addborder(view: whiteRoundedView, color: Const.white.cgColor, height: 1)
            whiteRoundedView.SetCornerRadius(view: whiteRoundedView, cornerRadius: 2.0)
            whiteRoundedView.addShadow(view: whiteRoundedView, color: Const.black.cgColor, width: -1, height: 1, radius: 2.0, opacity: 0.2)
        }
    }

    var btn = UIButton()
    
    func updateWithPresenter(presenter: ForumCellViewModelPresenter){
        presenter.updateTitleLable(label: lb_title)
        presenter.updateDetailLable(label: lb_detail)
        presenter.updateReplyCountLable(lable: lb_replyCount)
        presenter.updateThumbnailImage(imageView: imageview)
        presenter.updateImageRight(imageView: image_right)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Setting.shared.addObserver(self, forKeyPath: "themeType", options: .new, context: nil)
        
        self.tintColor = Setting.shared.mainColor()
        
        self.btn = UIButton(frame: CGRect(x: (-(32.0/2.0)-(25.0/2.0)), y: (self.contentView.frame.size.height/2.0)-(25/2.0), width: 25.0, height: 25.0))
        btn.setImage(UIImage(named: "UnCheck")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.setImage(UIImage(named: "Checked")?.withRenderingMode(.alwaysTemplate), for: .selected)
        btn.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        btn.adjustsImageWhenHighlighted = false
        self.addSubview(btn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(self.isEditing){
            btn.frame=CGRect(x: (32.0/2.0)-(25.0/2.0),  y: (self.contentView.frame.size.height/2.0)-(25/2.0), width: 25  , height: 25);
        }else{
            btn.frame=CGRect(x: -(32.0/2.0)-(25/2.0),  y: (self.contentView.frame.size.height/2.0)-(25/2.0), width: 25  , height: 25);
        }
    }
    
    @objc func buttonSelected(){
        print("btn clicked")
        self.btn.isSelected = !self.btn.isSelected
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        self.tintColor = Setting.shared.mainColor()
        image_right.image = image_right.image?.withRenderingMode(.alwaysTemplate)
        btn.imageView?.image = btn.imageView?.image?.withRenderingMode(.alwaysTemplate)
    }
}
