//
//  Const.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/15.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import Foundation
import UIKit


class Const {
    static let Screen_Size = UIScreen.main.bounds
//    static let Screen_Size = UIScreen.main.nativeBounds
    static var Screen_Width: CGFloat{
        get{
            if Screen_Size.height > Screen_Size.width{
                return Screen_Size.width
            }else{
                return Screen_Size.height
            }
        }
    }
    
    static var Screen_Height: CGFloat{
        get{
            if Screen_Size.height > Screen_Size.width{
                return Screen_Size.height
            }else{
                return Screen_Size.width
            }
        }
    }
    
//    static let Orange_Color:UIColor = UIColor(red: 255.0/255.0,green: 170.0/255.0,blue: 0/255,alpha: 1.0)
//    static let Green_Color:UIColor = UIColor(red: 255.0/255.0,green: 170.0/255.0,blue: 0/255,alpha: 1.0)
//    static let Purple_Color:UIColor = UIColor(red: 255.0/255.0,green: 170.0/255.0,blue: 0/255,alpha: 1.0)
    
    static let white = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
    static let black = UIColor(red: 3/255.0, green: 3/255.0, blue: 3/255.0, alpha: 1.0)
    static let coral = UIColor(red: 244/255.0, green: 111/255.0, blue: 96/255.0, alpha: 1.0)
    static let whiteSmoke = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
    static let grayChateau = UIColor(red: 163/255.0, green: 164/255.0, blue: 168/255.0, alpha: 0.2)
    
}

//Name:   iPhone 7 Plus
//Size:   (414.0, 736.0)
//Scale:  3.0
//Native: (1242.0, 2208.0)
//
//Name:   iPhone X
//Size:   (375.0, 812.0)
//Scale:  3.0
//Native: (1125.0, 2436.0)
//
//Name:   iPhone XR
//Size:   (414.0, 896.0)
//Scale:  2.0
//Native: (828.0, 1792.0)
//
//Name:   iPhone XS
//Size:   (375.0, 812.0)
//Scale:  3.0
//Native: (1125.0, 2436.0)
//
//Name:   iPhone XS Max
//Size:   (414.0, 896.0)
//Scale:  3.0
//Native: (1242.0, 2688.0)
