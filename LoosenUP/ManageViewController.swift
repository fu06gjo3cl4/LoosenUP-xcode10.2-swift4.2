//
//  ManageViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/6.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit

class ManageViewController: UIViewController {
    
    @IBOutlet weak var view_AccountManage: UIView!
    @IBOutlet weak var view_personalManage: UIView!
    @IBOutlet weak var view_logout: UIView!
    
    static let shared = ManageViewController()
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setting.shared.addObserver(self, forKeyPath: "themeType", options: .new, context: nil)
        
        UINavigationService.setNavBarColor(navigationController: self.navigationController!, color: Setting.shared.mainColor())
        UINavigationService.setedgefor_navigationbar(viewcontroller: self)
        
        let swipe_left = UISwipeGestureRecognizer(target: self, action: #selector(ManageViewController.swipe_tabs_left))
        swipe_left.direction = .left
        self.view.addGestureRecognizer(swipe_left)
        
        let swipe_right = UISwipeGestureRecognizer(target: self, action: #selector(ManageViewController.swipe_tabs_right))
        swipe_right.direction = .right
        self.view.addGestureRecognizer(swipe_right)
        
        
        let tap_account = UITapGestureRecognizer(target: self, action: #selector(self.toAccountManage))
        self.view_AccountManage.addGestureRecognizer(tap_account)
        
        let tap_personalmanage = UITapGestureRecognizer(target: self, action: #selector(self.toPersonalManage))
        self.view_personalManage.addGestureRecognizer(tap_personalmanage)
        
        let tap_logout = UITapGestureRecognizer(target: self, action: #selector(self.logout))
        self.view_logout.addGestureRecognizer(tap_logout)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func toAccountManage(){
        print("to account manage")
        
        let viewcontroller = AccountManageViewController()
        viewcontroller.title = "系統設置"
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @objc func toPersonalManage(){
        print("to personal manage")
        
        let viewcontroller = PersonalManageViewController()
        viewcontroller.title = "個人化管理"
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @objc func logout(){
        print("logout")
    }

    @objc func swipe_tabs_left(){
        print("left")
        HomeTabBarController.shared.swipe_tabs_left()
    }
    
    @objc func swipe_tabs_right(){
        print("right")
        HomeTabBarController.shared.swipe_tabs_right()
    }
}

extension ManageViewController {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
//        self.navigationController?.navigationBar.tintColor = Setting.shared.mainColor()
        self.navigationController?.navigationBar.barTintColor = Setting.shared.mainColor()
        
    }
    
}
