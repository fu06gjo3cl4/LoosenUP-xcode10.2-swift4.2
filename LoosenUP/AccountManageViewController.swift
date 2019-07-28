//
//  AccountManageViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/26.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit

class AccountManageViewController: UIViewController {
    
    
    @IBOutlet weak var btn_theme1: UIButton!
    @IBOutlet weak var btn_theme2: UIButton!
    @IBOutlet weak var btn_theme3: UIButton!
    
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
        
        btn_theme1.backgroundColor = UIColor(red: 255.0/255.0,green: 170.0/255.0,blue: 0/255,alpha: 1.0)
        btn_theme2.backgroundColor = UIColor(red: 0.0/255.0,green: 255.0/255.0,blue: 170.0/255,alpha: 1.0)
        btn_theme3.backgroundColor = UIColor(red: 170/255.0,green: 0.0/255.0,blue: 255.0/255,alpha: 1.0)
        
        Setting.shared.addObserver(self, forKeyPath: "themeType", options: .new, context: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        
        
    }
    
    
}
