//
//  PersonalQualityViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/4/19.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit
import SwipeMenuViewController

class PersonalQualityViewController: UIViewController {
    
    @IBOutlet weak var swipeMenuView: SwipeMenuView!
    
    var array = ["Segment1", "Segment2", "Segment3"]
    private var lastContentOffset: CGFloat = 0
    private var isNavBarHidden = false
    private var tapPoint: CGPoint = CGPoint(x: 0, y: 0)
    private var collectionCellsCount = 15
    private var viewControllers = [ContentViewController]()
    private var executeCount = 0
    private var isGoingTop = false
    
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
                           completion: { (finished: Bool) in
                                self.isGoingTop = false
                            })
            self.isNavBarHidden = false
        }else{
            
        }
    }
    
    @objc func TapEvent(recognizer : UIGestureRecognizer){
        let tappedPoint: CGPoint = recognizer.location(in: self.view!)
        print(tappedPoint)
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
    
    //will call twice, a bug issue still open at SwipeMenuViewController, this is a temporary solution
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        
        executeCount += 1
        
        let vc = ContentViewController()
        let customView = CustomUIScrollView(frame: vc.view.bounds)
        customView.scrollview.delegate = self
        vc.customView = customView
        vc.customView.backgroundColor = UIColor.clear
        
        for constraint in vc.customView.collectionView.constraints {
            if constraint.identifier == "heightOfCollectionView" {
                constraint.constant = vc.customView.collectionView.collectionViewLayout.collectionViewContentSize.height
            }
        }
        vc.customView.layoutIfNeeded()
        
        let tapEvent = UITapGestureRecognizer(target: self, action: #selector(TapEvent))
        vc.customView.addGestureRecognizer(tapEvent)
        vc.view.addSubview(vc.customView!)
        
        vc.customView.addObserver(self, forKeyPath: "isGoTopBtnActive", options: .new, context: nil)
        
        if executeCount < array.count+1{
            return UIViewController()
        }else{
            self.viewControllers.append(vc)
            print(viewControllers.count)
            return vc
        }
//        return vc
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
            if isGoingTop == false{
                self.swipe_up()
            }else{}
            
            if(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.bounds.size.height - 300)){
                
                //--若有內容未載入，擴充scrollView&contentView&collectionView長度並載入內容---
                //else顯示回到最頂端按鈕在最下方
                let vc = self.viewControllers[swipeMenuView.currentIndex]
                
                if(vc.customView.collectionCellsCount < vc.customView.totalCellCount){
                    vc.customView?.scrollview.contentSize.height += 1500
                    vc.customView?.contentview.frame.size.height = (vc.customView?.scrollview.contentSize.height)!
                    
                    vc.customView.collectionCellsCount += 20
                    vc.customView.collectionView.reloadData()
                    for constraint in vc.customView.collectionView.constraints {
                        if constraint.identifier == "heightOfCollectionView" {
                            constraint.constant = vc.customView.collectionView.collectionViewLayout.collectionViewContentSize.height
                        }
                    }
                    vc.customView.layoutIfNeeded()
                }else{
                    
                    let distance = vc.customView.scrollview.contentSize.height-vc.customView.collectionView.contentSize.height
                    
                    vc.customView.btnBottom.isHidden = false
                    vc.customView.btnBottom.isEnabled = true
                    
                    vc.customView.btnBottom.layer.frame =
                        CGRect(x: 0, y: vc.customView.scrollview.contentSize.height-distance, width: vc.customView.btnBottom.frame.width, height: vc.customView.btnBottom.frame.height)
                    
                    print(vc.customView.btnBottom.frame)
                }
                //---------------------------------
            }
            
        }
    }
    
}

extension PersonalQualityViewController{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        swipe_down()
        isGoingTop = true
    }
}
