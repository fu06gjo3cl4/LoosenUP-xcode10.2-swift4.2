//
//  PersonalQualityViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/4/19.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit
import Segmentio
import SwipeMenuViewController

class PersonalQualityViewController: UIViewController {
    
    @IBOutlet weak var swipeMenuView: SwipeMenuView!
    
    var array = ["Segment1","Segment2","Segment3","Segment4","Segment5","Segment6","Segment7","Segment8",]
    private var lastContentOffset: CGFloat = 0
    private var isNavBarHidden = false
    private var tapPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self
        
        let options: SwipeMenuViewOptions = .init()
        
        swipeMenuView.reloadData(options: options)
    }
    
    @objc func swipe_up(){
        print("PersonalQualityVC be swipe up")
        if isNavBarHidden {
            
        }else{
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                            self.navigationController?.navigationBar.center.y -= ((self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height)
                            self.view.center.y -= ((self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height)
                            },
                           completion: nil)
            self.isNavBarHidden = true
        }
    }
    
    @objc func swipe_down(){
        print("PersonalQualityVC be swipe down")
        if isNavBarHidden {
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                            self.navigationController?.navigationBar.center.y += ((self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height)
                            self.view.center.y += ((self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height)
                            },
                           completion: nil)
            self.isNavBarHidden = false
        }else{
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension PersonalQualityViewController: SwipeMenuViewDataSource {
    
    //MARK - SwipeMenuViewDataSource
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return array.count
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return array[index]
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        let vc = ContentViewController()
        
        let customView = CustomUIScrollView(frame: vc.view.bounds)
        customView.scrollview.delegate = self
        vc.view.addSubview(customView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.tapEvent))
        customView.scrollview.addGestureRecognizer(tapGestureRecognizer)
        
        return vc
    }
}

extension PersonalQualityViewController: SwipeMenuViewDelegate {
    
    // MARK - SwipeMenuViewDelegate
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewWillSetupAt currentIndex: Int) {
        // Codes
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewDidSetupAt currentIndex: Int) {
        // Codes
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        // Codes
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        // Codes
    }
}

extension PersonalQualityViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.tapPoint.y > scrollView.contentOffset.y) {
            self.swipe_down()
        }
        else if (self.tapPoint.y < scrollView.contentOffset.y) {
            self.swipe_up()
        }
    }
    
    @objc func tapEvent(recognizer : UIGestureRecognizer){
        self.tapPoint = recognizer.location(in: self.swipeMenuView!)
        print("tapPoint.y: \(tapPoint.y)")
    }
    
}
