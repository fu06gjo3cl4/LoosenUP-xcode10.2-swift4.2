//
//  DynamicMessageViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/12.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import UIKit
import SwipeMenuViewController
import SwiftyJSON

class DynamicMessageViewController: UIViewController {
    
    static let shared = DynamicMessageViewController()
    
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
    private var viewControllers = [UIViewController]()
    private var executeCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setting.shared.addObserver(self, forKeyPath: "themeType", options: .new, context: nil)
        
        UINavigationService.setNavBarColor(navigationController: self.navigationController!, color: Setting.shared.mainColor())
        
        //swipe menu
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self
        let options: SwipeMenuViewOptions = .init()
        swipeMenuView.reloadData(options: options)
        
    }
    
}
extension DynamicMessageViewController: SwipeMenuViewDataSource {
    
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
        
        let vc = ContainerOfDynamicMessageViewController()
        
        if executeCount < array.count+1{
            return UIViewController()
        }else{
            self.viewControllers.append(vc)
            print(viewControllers.count)
            return vc
        }
    }
}

extension DynamicMessageViewController: SwipeMenuViewDelegate {
    
    // MARK - SwipeMenuViewDelegate
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewWillSetupAt currentIndex: Int) {
        // Codes
        print("viewwillsetup at currentindex: \(currentIndex)")
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewDidSetupAt currentIndex: Int) {
        // Codes
        print("viewdidsetup at currentindex: \(currentIndex)")
        let vc = self.viewControllers[currentIndex] as! ContainerOfDynamicMessageViewController
        vc.requestData()
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        // Codes
        let vc = self.viewControllers[toIndex] as! ContainerOfDynamicMessageViewController
        vc.requestData()
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        // Codes
        
    }
}

extension DynamicMessageViewController{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath! == "themeType"{
            self.navigationController?.navigationBar.barTintColor = Setting.shared.mainColor()
        }
        
    }
}
