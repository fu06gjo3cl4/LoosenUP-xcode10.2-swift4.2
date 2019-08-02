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
    
    var array = ["Segment1", "Segment2", "Segment3", "Segment4", "Segment5", "Segment6", "Segment7", ]
    private var lastContentOffset: CGFloat = 0
    private var isNavBarHidden = false
    private var tapPoint: CGPoint = CGPoint(x: 0, y: 0)
    private var viewControllers = [ContentViewController]()
    
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
        
        vc.customView = customView
        vc.view.addSubview(vc.customView!)
        
        //***待優化
        //SwipeMenuViewController 產生一個viewcontroller 會跑兩次這個動作，會產生兩倍的vc，並使用第二輪產生的vc顯示
        //第一輪產生array.count個vc，但沒有使用，使用的是第二輪產生的vc，因此使用上從[array.count]開始
        viewControllers.append(vc)
        
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
            print(scrollView.contentSize.height)
            print(scrollView.bounds.size.height)
            
            print(scrollView.contentOffset.y)
        }
        else if (self.tapPoint.y < scrollView.contentOffset.y) {
            self.swipe_up()
            
            
            if(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.bounds.size.height - 300)){
                //-----若有內容未載促入，仔入並顯示-----
                
                //---------------------------------
                //擴充scrollview&contentview長度
                let view = UIView(frame: CGRect(x: 10, y: scrollView.contentSize.height, width: scrollView.bounds.size.width-20, height: scrollView.bounds.size.height/2))
                view.addborder(view: view, color: Setting.shared.mainColor().cgColor, height: 2)
                
                let vc = self.viewControllers[swipeMenuView.currentIndex+array.count]
                vc.customView?.scrollview.contentSize.height += 1500
                vc.customView?.contentview.frame.size.height = (vc.customView?.scrollview.contentSize.height)!
                
                vc.customView.contentview.addSubview(view)
                
                print(vc.customView.scrollview.contentSize)
                print(vc.customView.contentview.frame.size)
                //---------------------------------
            }
            
        }
    }
    
}
