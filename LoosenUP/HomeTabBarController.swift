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
    
    static let shared = HomeTabBarController(nibName: "HomeTabBarController", bundle: nil)
    
    var toolbar = UIToolbar()
    var toolView = UIView()
    var middleButton = UIButton()
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.nibSetup()
    }
    
    private func nibSetup(){
        //臨時解
        toolView = UIView(frame:CGRect(x:0, y:Const.Screen_Height, width:Const.Screen_Width, height:64))
        toolView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        toolView.backgroundColor = Const.white
        
        let toolViewTap = UITapGestureRecognizer(target: self, action: #selector(self.toolItemTrashAction))
        toolView.addGestureRecognizer(toolViewTap)
        
        let deleteLabel = UILabel(frame: CGRect(x:0, y:0, width:Const.Screen_Width, height:64))
        deleteLabel.text = NSLocalizedString("EditMode.delete", comment: "")
        deleteLabel.textAlignment = .center
        deleteLabel.isEnabled = false
        toolView.addSubview(deleteLabel)
        
        self.view.addSubview(toolView)
        setupMiddleButton()
    }
    
    @objc func toolItemTrashAction(){
        print("toolItemTrashAction")
        
        ForumViewController.shared.deleteSelectedRows()
    }
    
    func showToolBar(){
        print("show toolbar action")
        
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
                        self.toolView.center.y -= 64
                        },
                       completion: { finish in
                        self.animationTabBarHidden(true)
                        self.middleButton.isHidden = true
                        })
    }
    
    func hideToolBar(){
        print("hide toolbar action")
        
        self.animationTabBarHidden(false)
        self.middleButton.isHidden = false
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.toolView.center.y += 64
        },
                       completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setting.shared.addObserver(self, forKeyPath: "themeType", options: .new, context: nil)
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
            deselectItem.deselectAnimation()
            
            let container : UIView = animationItem.iconView!.icon.superview!
            let location = CGPoint(x: container.frame.midX, y: container.frame.midY)
            Ripple.border(self.view, locationInView: location, color: Setting.shared.mainColor())
            
            selectedIndex = gestureView.tag
            delegate?.tabBarController?(self, didSelect: controller)
            
        } else if selectedIndex == currentIndex {
            self.animatedItems[currentIndex].playAnimation()
            let container : UIView = HomeTabBarController.shared.animatedItems[currentIndex].iconView!.icon.superview!
            let location = CGPoint(x: container.frame.midX, y: container.frame.midY)
            Ripple.border(self.view, locationInView: location, color: Setting.shared.mainColor())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func swipe_tabs_left(){
        print("swipe left")
        /*
        let rootvc = HomeTabBarController.shared
        if rootvc.selectedIndex < rootvc.children.count-1 {
            guard let items = rootvc.tabBar.items as? [RAMAnimatedTabBarItem]else {
                fatalError("items must inherit RAMAnimatedTabBarItem")
            }
            
            let animationItem : RAMAnimatedTabBarItem = items[rootvc.selectedIndex+1]
            animationItem.playAnimation()
            
            let deselectItem = items[rootvc.selectedIndex]
            deselectItem.deselectAnimation()
            
            let container : UIView = animationItem.iconView!.icon.superview!
            
            let location = CGPoint(x: container.frame.midX, y: container.frame.midY)
            print(location)
            Ripple.border(rootvc.view, locationInView: location, color: Setting.shared.mainColor())
            
            rootvc.selectedIndex += 1
            let controller = rootvc.children[rootvc.selectedIndex]
            rootvc.delegate?.tabBarController?(rootvc, didSelect: controller)
        }
        */
    }
    
    func swipe_tabs_right(){
        print("swipe right")
        /*
        let rootvc = HomeTabBarController.shared
        if rootvc.selectedIndex > 0 {
            guard let items = rootvc.tabBar.items as? [RAMAnimatedTabBarItem]else {
                fatalError("items must inherit RAMAnimatedTabBarItem")
            }
            
            let animationItem : RAMAnimatedTabBarItem = items[rootvc.selectedIndex-1]
            animationItem.playAnimation()
            
            let deselectItem = items[rootvc.selectedIndex]
            deselectItem.deselectAnimation()
            
            let container : UIView = animationItem.iconView!.icon.superview!
            
            let location = CGPoint(x: container.frame.midX, y: container.frame.midY)
            print(location)
            Ripple.border(rootvc.view, locationInView: location, color: Setting.shared.mainColor())
            
            rootvc.selectedIndex -= 1
            let controller = rootvc.children[rootvc.selectedIndex]
            rootvc.delegate?.tabBarController?(rootvc, didSelect: controller)
        }
        */
    }
    
    func setupMiddleButton() {
        
        middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width/2)-(64/2), y: self.view.bounds.height-(self.tabBar.bounds.height/2)-(64/2), width: 64, height: 64))
        
        tabBar.barTintColor = UIColor.white
        middleButton.backgroundColor = tabBar.barTintColor
        middleButton.layer.borderWidth = 0.5
        middleButton.layer.borderColor = UIColor.lightGray.cgColor
        middleButton.layer.cornerRadius = middleButton.frame.height/2
        view.addSubview(middleButton)
        
        middleButton.setImage(UIImage(named: "emptyIcon"), for: .normal)
        middleButton.addTarget(self, action: #selector(middleButtonAction(sender:)), for: .touchUpInside)
        
        view.layoutIfNeeded()
    }
    
    @objc private func middleButtonAction(sender: UIButton) {
        print("middleButtonAction")
    }
    
}

extension HomeTabBarController {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //RAMAnimatedTabBarItem 的title數值改變會創建一個新的textlable 若要修改titile要修改源碼
        //self.viewControllers?[0].tabBarItem.title = "fu06gjo3cl4"
        //self.animatedItems[selectedIndex].title = "changed"
        print("tabbaritems color change")
        
        for tabBarItem in animatedItems{
            tabBarItem.animation.iconSelectedColor = Setting.shared.mainColor()
            tabBarItem.animation.textSelectedColor = Setting.shared.mainColor()
        }
        
        self.animatedItems[selectedIndex].playAnimation()
    }
    
}



