//
//  UIScrollView.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/1.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import UIKit

class CustomUIScrollView: UIView{
    
    var view:UIView!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var contentview: UIView!
    
    @IBOutlet weak var btnTop: UIButton!{
        didSet{
            btnTop.isEnabled = false
            btnTop.isHidden = true
        }
    }
    @IBOutlet weak var btnBottom: UIButton!{
        didSet {
            btnBottom.isEnabled = false
            btnBottom.isHidden = true
        }
    }
    
    @IBAction func btnTopAction(_ sender: Any) {
        scrollToBottom()
    }
    
    @IBAction func btnBottomAction(_ sender: Any) {
        scrollToTop()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomUIScrollView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func scrollToBottom(){
        let bottomOffset = CGPoint(x: 0, y: scrollview.contentSize.height - scrollview.bounds.size.height)
        scrollview.setContentOffset(bottomOffset, animated: true)
    }
    
    func scrollToTop(){
        let bottomOffset = CGPoint(x: 0, y: 0)
        scrollview.setContentOffset(bottomOffset, animated: true)
    }
}
