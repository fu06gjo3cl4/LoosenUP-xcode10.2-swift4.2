//
//  Setting.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/7/22.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import Foundation
import UIKit

class Setting :NSObject{
    
    static let shared = Setting()
    
    private override init(){
        let user = UserDefaults.standard
        if user.object(forKey: "ThemeType") != nil{
            self.themeType = ThemeType(rawValue: user.object(forKey: "ThemeType") as! Int)!
        }
    }
    
    @objc dynamic private var themeType: ThemeType = .OrangeTheme
    
    func mainColor() -> UIColor {
        switch themeType {
        case .OrangeTheme:
            return UIColor(red: 255.0/255.0,green: 170.0/255.0,blue: 0/255,alpha: 1.0)
        case .GreenTheme:
            return UIColor(red: 0.0/255.0,green: 255.0/255.0,blue: 170.0/255,alpha: 1.0)
        case .PurpleTheme:
            return UIColor(red: 170/255.0,green: 0.0/255.0,blue: 255.0/255,alpha: 1.0)
        }
    }
    
    func chageThemeType(newthemeType: ThemeType) {
        self.themeType = newthemeType
        let user = UserDefaults.standard
        user.set(themeType.rawValue, forKey: "ThemeType")
        user.synchronize()
    }
    
    func getThemeType() -> ThemeType{
        return themeType
    }
    
    override func removeObserver(_ observer: NSObject, forKeyPath keyPath: String) {
        // todo: check observer and keyPath exist or not.
        if isObserverAndKeyPathExist(observer: observer, key: keyPath){
            super.removeObserver(observer, forKeyPath: keyPath)
        }
    }
    
    func isObserverAndKeyPathExist(observer: Any?, key: String?) -> Bool{
        
//        let info = Unmanaged<AnyObject>
//            .fromOpaque(self.observationInfo!)
//            .takeUnretainedValue()
//        let array = info.value(forKey: "_observances") as? [Any]
//        for objc in array ?? [] {
//            let Properties = (objc as AnyObject).value(forKeyPath: "_property")
//            let newObserver = (objc as AnyObject).value(forKeyPath: "_observer")
//
//            let keyPath = (Properties as AnyObject).value(forKeyPath: "_keyPath") as? String
//            if (key == keyPath) && newObserver == observer {
//                return true
//            }
//        }
        return true//false
    }
    
    
}

@objc enum ThemeType: Int{
    case OrangeTheme = 1
    case GreenTheme = 2
    case PurpleTheme = 3
}
