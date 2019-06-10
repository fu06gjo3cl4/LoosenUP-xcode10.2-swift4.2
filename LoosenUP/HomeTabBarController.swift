//
//  HomeTabBarController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/6.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class HomeTabBarController: RAMAnimatedTabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let buttonImage = UIImage(named: "icon2"){
//            self.addCenterButtonWithImage(buttonImage: buttonImage , highlightImage: buttonImage)
//        }
        
        setupMiddleButton()
        
    }
    
    override func tapHandler(_ gesture: UIGestureRecognizer) {
        
        print("HomeTabBarController's tapHandler")
        
        guard let items = tabBar.items as? [RAMAnimatedTabBarItem],
            let gestureView = gesture.view else {
                fatalError("items must inherit RAMAnimatedTabBarItem")
        }
        
        let currentIndex = gestureView.tag
        
        if items[currentIndex].isEnabled == false { return }
        
        let controller = self.children[currentIndex]
        
        if let shouldSelect = delegate?.tabBarController?(self, shouldSelect: controller)
            , !shouldSelect {
            return
        }
        
        if selectedIndex != currentIndex {
            let animationItem : RAMAnimatedTabBarItem = items[currentIndex]
            animationItem.playAnimation()
            
            let deselectItem = items[selectedIndex]
            
//            let containerPrevious : UIView = deselectItem.iconView!.icon.superview!
//            containerPrevious.backgroundColor = items[currentIndex].bgDefaultColor
            
            deselectItem.deselectAnimation()
            
            let container : UIView = animationItem.iconView!.icon.superview!
//            container.backgroundColor = items[currentIndex].bgSelectedColor
            
            //-----擴充-----
            let location = CGPoint(x: container.frame.midX, y: container.frame.midY)
            print(location)
            Ripple.border(self.view, locationInView: location, color: Const.Main_Color)
            //-------------
            
            selectedIndex = gestureView.tag
            delegate?.tabBarController?(self, didSelect: controller)
            
        } else if selectedIndex == currentIndex {
            
            if let navVC = self.viewControllers![selectedIndex] as? UINavigationController {
                navVC.popToRootViewController(animated: true)
            }
        }
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("test")
        let location = item.accessibilityActivationPoint
        Ripple.border(self.view, absolutePosition: location, color: UIColor.black)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    static func swipe_tabs_left(){
//        let rootvc = UIApplication.shared.keyWindow?.rootViewController as! HomeTabBarController
        print("left")
//        rootvc.selectedIndex = (rootvc.selectedIndex)+1
//        let animationItem : RAMAnimatedTabBarItem = items[rootvc.selectedIndex]
//        animationItem.playAnimation()
        
    }
    
    static func swipe_tabs_right(){
//        let rootvc = UIApplication.shared.keyWindow?.rootViewController as! HomeTabBarController
        print("right")
//        rootvc.selectedIndex = (rootvc.selectedIndex)-1
    }
    
    //func 1
    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        
        var menuButtonFrame = menuButton.frame
        let rectBoundTabbar = self.tabBar.bounds//CGRect
        menuButtonFrame.origin.y = view.bounds.height - ((64 - rectBoundTabbar.height)/2 + rectBoundTabbar.height)//midY//menuButtonFrame.height/2
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        
        tabBar.barTintColor = UIColor.white
        menuButton.backgroundColor = tabBar.barTintColor
        menuButton.layer.borderWidth = 0.5
        menuButton.layer.borderColor = UIColor.lightGray.cgColor
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        view.addSubview(menuButton)
        
        menuButton.setImage(UIImage(named: "emptyIcon"), for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        
        view.layoutIfNeeded()
    }
    
    
    // MARK: - Actions
    
    @objc private func menuButtonAction(sender: UIButton) {
        selectedIndex = 2
        print("test")
    }
    
}





