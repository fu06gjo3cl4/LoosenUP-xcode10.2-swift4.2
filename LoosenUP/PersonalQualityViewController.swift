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
    
    static let shared = PersonalQualityViewController()
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var swipeMenuView: SwipeMenuView!
    
    var array = ["Segment1", "Segment2", "Segment3"]
    private var lastContentOffset: CGFloat = 0
    private var isNavBarHidden = false
    private var tapPoint: CGPoint = CGPoint(x: 0, y: 0)
    private var viewControllers = [ContentViewController]()
    private var executeCount = 0
    private var isGoingTop = false
    private var remainNavBarY:CGFloat?
    private var remainViewY:CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setting.shared.addObserver(self, forKeyPath: "themeType", options: .new, context: nil)
        
        UINavigationService.setNavBarColor(navigationController: self.navigationController!, color: Setting.shared.mainColor())
        
        //swipe menu
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self
        let options: SwipeMenuViewOptions = .init()
        swipeMenuView.reloadData(options: options)
        
        //search btn
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(toSearchVC))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
    }
    
    @objc func toSearchVC(){
        print("toSearchVC")
        let vc = SearchContainerViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if remainNavBarY != nil && isNavBarHidden == true{
            self.navigationController?.navigationBar.center.y = remainNavBarY!
            self.view.center.y = remainViewY!
            print("viewDidLayoutSubviews is running")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for vc in viewControllers{
            vc.customView.collectionView.dataSource = vc.customView
            vc.customView.collectionView.delegate = vc.customView
        }
        
        let vc = self.viewControllers[swipeMenuView.currentIndex]
        if(vc.customView.collectionCellsCount+20 < vc.customView.totalCellCount){
            vc.customView.collectionCellsCount += 20
            vc.customView.collectionView.reloadData()
            for constraint in vc.customView.collectionView.constraints {
                if constraint.identifier == "heightOfCollectionView" {
                    constraint.constant = vc.customView.collectionView.collectionViewLayout.collectionViewContentSize.height
                }
            }
            for constraint in vc.customView.scrollview.constraints{
                if constraint.identifier == "contentViewHeight"{
                    constraint.constant = vc.customView.collectionView.collectionViewLayout.collectionViewContentSize.height
                }
            }
            vc.customView.layoutIfNeeded()
            vc.customView.isInitDataOrNot = true
        }else if vc.customView.collectionCellsCount != vc.customView.totalCellCount{
            vc.customView.collectionCellsCount = vc.customView.totalCellCount
            vc.customView.collectionView.reloadData()
            for constraint in vc.customView.collectionView.constraints {
                if constraint.identifier == "heightOfCollectionView" {
                    constraint.constant = vc.customView.collectionView.collectionViewLayout.collectionViewContentSize.height
                }
            }
            for constraint in vc.customView.scrollview.constraints{
                if constraint.identifier == "contentViewHeight"{
                    constraint.constant = vc.customView.collectionView.collectionViewLayout.collectionViewContentSize.height
                }
            }
            vc.customView.layoutIfNeeded()
            vc.customView.isInitDataOrNot = true
        }else{
            
        }
    }
    
    @objc func swipe_up(){
        print("PersonalQualityVC be swipe up")
        
        if isNavBarHidden {
            
        }else{
            self.isNavBarHidden = true
            self.remainNavBarY = (self.navigationController?.navigationBar.center.y)! - ((self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height)
            self.remainViewY = self.view.center.y - ((self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height)
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                            self.navigationController?.navigationBar.center.y = self.remainNavBarY!
                            self.view.center.y = self.remainViewY!
                            },
                           completion: {(finished: Bool) in
                            self.isGoingTop = true
                            
            })
        }
    }
    
    @objc func swipe_down(){
        print("PersonalQualityVC be swipe down")
        
        if isNavBarHidden {
            self.isNavBarHidden = false
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                            self.navigationController?.navigationBar.center.y += ((self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height)
                            self.view.center.y += ((self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height)
                            },
                           completion: { (finished: Bool) in
                            self.isGoingTop = false
                            self.remainNavBarY = (self.navigationController?.navigationBar.center.y)!
                            self.remainViewY = self.view.center.y
            })
        }else{
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        Setting.shared.removeObserver(self, forKeyPath: "themeType")
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
        
        for constraint in vc.customView.collectionView.constraints {
            if constraint.identifier == "heightOfCollectionView" {
                constraint.constant = vc.customView.collectionView.collectionViewLayout.collectionViewContentSize.height
            }
        }
        for constraint in vc.customView.scrollview.constraints{
            if constraint.identifier == "contentViewHeight"{
                constraint.constant = vc.customView.collectionView.collectionViewLayout.collectionViewContentSize.height
            }
        }
        vc.customView.layoutIfNeeded()
        
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
        //is init or not? init , don't do anything
        let vc = self.viewControllers[toIndex]
        
        if !vc.customView.isInitDataOrNot{
            if(vc.customView.collectionCellsCount+20 < vc.customView.totalCellCount){
                vc.customView.collectionCellsCount += 20
                vc.customView.collectionView.reloadData()
                for constraint in vc.customView.collectionView.constraints {
                    if constraint.identifier == "heightOfCollectionView" {
                        constraint.constant = vc.customView.collectionView.collectionViewLayout.collectionViewContentSize.height
                    }
                }
                vc.customView.layoutIfNeeded()
                vc.customView.isInitDataOrNot = true
            }else if vc.customView.collectionCellsCount != vc.customView.totalCellCount{
                vc.customView.collectionCellsCount = vc.customView.totalCellCount
                vc.customView.collectionView.reloadData()
                for constraint in vc.customView.collectionView.constraints {
                    if constraint.identifier == "heightOfCollectionView" {
                        constraint.constant = vc.customView.collectionView.collectionViewLayout.collectionViewContentSize.height
                    }
                }
                vc.customView.layoutIfNeeded()
                vc.customView.isInitDataOrNot = true
            }else{}
        }
    }
}

extension PersonalQualityViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let vc = self.viewControllers[swipeMenuView.currentIndex]
        
//        print(self.tapPoint.y)
//        print(scrollView.contentOffset.y)
        
        if (self.tapPoint.y > scrollView.contentOffset.y) && isNavBarHidden == true {
            self.swipe_down()
        }
        else if (self.tapPoint.y < scrollView.contentOffset.y) {
            if isGoingTop == false && isNavBarHidden == false {
                self.swipe_up()
            }else{}
            
            if(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.bounds.size.height - 300)){
                
                //若有內容未載入，擴充scrollView&contentView&collectionView長度並載入內容
                if(vc.customView.collectionCellsCount+20 < vc.customView.totalCellCount){
                    
                    vc.customView.collectionCellsCount += 20
                    vc.customView.collectionView.reloadData()
                    for constraint in vc.customView.collectionView.constraints {
                        if constraint.identifier == "heightOfCollectionView" {
                            constraint.constant = vc.customView.collectionView.collectionViewLayout.collectionViewContentSize.height
                        }
                    }
                    for constraint in vc.customView.scrollview.constraints{
                        if constraint.identifier == "contentViewHeight"{
                            constraint.constant = vc.customView.collectionView.collectionViewLayout.collectionViewContentSize.height
                        }
                    }
                    vc.customView.layoutIfNeeded()
                    
                }else if vc.customView.collectionCellsCount != vc.customView.totalCellCount{
                    //載入全部資料
                    vc.customView.collectionCellsCount = vc.customView.totalCellCount
                    vc.customView.collectionView.reloadData()
                    for constraint in vc.customView.collectionView.constraints {
                        if constraint.identifier == "heightOfCollectionView" {
                            constraint.constant = vc.customView.collectionView.collectionViewLayout.collectionViewContentSize.height
                        }
                    }
                    for constraint in vc.customView.scrollview.constraints{
                        if constraint.identifier == "contentViewHeight"{
                            constraint.constant = vc.customView.collectionView.collectionViewLayout.collectionViewContentSize.height
                        }
                    }
                    vc.customView.layoutIfNeeded()
                    
                    
                    //空出下方與tabbar的距離，用以呈現底部按鈕或其他view
                    scrollView.contentSize.height = vc.customView.collectionView.collectionViewLayout.collectionViewContentSize.height+500
                    
                }else{
                    //顯示最底部按鈕
                    let distance = vc.customView.scrollview.contentSize.height-vc.customView.collectionView.contentSize.height
                    vc.customView.btnBottom.isHidden = false
                    vc.customView.btnBottom.isEnabled = true
                    
                    vc.customView.btnBottom.layer.frame =
                        CGRect(x: 0, y: vc.customView.scrollview.contentSize.height-distance, width: vc.customView.btnBottom.frame.width, height: vc.customView.btnBottom.layer.frame.height)
                    
                    vc.view.bringSubviewToFront(vc.customView)
                    
                }
            }
            
        }
    }
    
}

extension PersonalQualityViewController{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath! == "isGoTopBtnActive"{
            swipe_down()
            isGoingTop = true
        }
        
        if keyPath! == "themeType"{
            self.navigationController?.navigationBar.barTintColor = Setting.shared.mainColor()
//            self.viewControllers[swipeMenuView.currentIndex].customView.collectionView.reloadData()
        }
        
    }
}


//To do : change data update by better way like https://medium.com/flawless-app-stories/a-better-way-to-update-uicollectionview-data-in-swift-with-diff-framework-924db158db86
//collectionView.performBatchUpdates
