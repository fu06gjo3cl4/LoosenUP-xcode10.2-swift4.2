//
//  RAMAnimateService.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/4/14.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import Foundation
import UIKit
import RAMAnimatedTabBarController

class RAMAnimateService {
    static func setItemColor(tabbarItem:RAMAnimatedTabBarItem,color:UIColor){
        tabbarItem.textColor = color
        tabbarItem.iconColor = color
    }
    
    static func setItemSelectedColor(Item:RAMItemAnimation,color:UIColor){
        Item.textSelectedColor = color
        Item.iconSelectedColor = color
    }
    
    
}

