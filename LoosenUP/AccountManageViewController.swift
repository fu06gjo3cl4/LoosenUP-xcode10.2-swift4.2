//
//  AccountManageViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/26.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit

class AccountManageViewController: UIViewController {
    
    @IBAction func btn_theme1(_ sender: Any) {
        Setting.shared.chageThemeType(newthemeType: ThemeType.OrangeTheme)
    }
    
    @IBAction func btn_theme2(_ sender: Any) {
        Setting.shared.chageThemeType(newthemeType: ThemeType.GreenTheme)
    }
    
    @IBAction func btn_theme3(_ sender: Any) {
        Setting.shared.chageThemeType(newthemeType: ThemeType.PurpleTheme)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setting.shared.addObserver(self, forKeyPath: "themeType", options: .new, context: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        
        
    }
    
    
}
