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
    
    @IBOutlet weak var scrollview: UIScrollView!{
        didSet{
//            self.scrollview.delegate = self
        }
    }
    
//    weak var scrollViewEventDelegate: ScrollViewEventDelegate?
    
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
    
    
    
//    let swipe_up = UISwipeGestureRecognizer(target: self, action: #selector(self.swipe_up))
//    swipe_up.direction = .up
//    self.view.addGestureRecognizer(swipe_up)
//
//    let swipe_down = UISwipeGestureRecognizer(target: self, action: #selector(self.swipe_down))
//    swipe_down.direction = .down
//    self.view.addGestureRecognizer(swipe_down)
    
}



//extension CustomUIScrollView: UIScrollViewDelegate{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
////        scrollViewEventDelegate?.scrollViewDidScrollEvent()
//    }
//
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
////        scrollViewEventDelegate?.scrollViewWillEndDragging()
//        print("scrollview will end dragging")
//    }
//}



//protocol ScrollViewEventDelegate: AnyObject {
//    func scrollViewDidScrollEvent()
//    func scrollViewWillEndDragging()
//}
