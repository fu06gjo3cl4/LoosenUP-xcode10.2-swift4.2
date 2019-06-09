//
//  UINavigationService.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/20.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import Foundation
import UIKit


class UINavigationService{
    static func setedgefor_navigationbar(viewcontroller:UIViewController){
        viewcontroller.edgesForExtendedLayout = UIRectEdge.bottom
        viewcontroller.navigationController?.navigationBar.isTranslucent = false
    }
    
    static func setNavBarColor(navigationController:UINavigationController,color:UIColor){
        navigationController.navigationBar.barTintColor = color
        navigationController.navigationBar.isTranslucent = false
    }
    
    
}
