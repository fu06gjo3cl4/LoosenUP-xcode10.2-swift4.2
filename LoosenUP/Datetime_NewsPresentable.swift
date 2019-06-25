//
//  datetime_NewsPresentable.swift
//  FocusUp
//
//  Created by 黃麒安 on 2016/2/29.
//  Copyright © 2016年 黃麒安. All rights reserved.
//

import Foundation
import UIKit



protocol Datetime_NewsPresentable{
    var datetime : String {get}
    var datetime_Color : UIColor {get}
    var datetime_Font : UIFont {get}
    
    func updatedatetimeLable(label:UILabel)
}

extension Datetime_NewsPresentable {
    var datetime_Color : UIColor{
        return UIColor.black
    }
    
    var datetime_Font : UIFont {
        return UIFont(name: "Helvetica", size: 18)!
    }
    
    func updatedatetimeLable(label:UILabel){
        label.text = datetime
        label.textColor = datetime_Color
        label.font = datetime_Font
    }
    
}
