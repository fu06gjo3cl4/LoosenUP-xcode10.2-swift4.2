//
//  Title_NewsPresentable.swift
//  FocusUp
//
//  Created by 黃麒安 on 2016/2/29.
//  Copyright © 2016年 黃麒安. All rights reserved.
//

import Foundation
import UIKit

protocol Title_NewsPresentable{
    var title : String {get}
    var title_Color : UIColor {get}
    var title_Font : UIFont {get}
    
    func updateTitleLable(label:UILabel)
}

extension Title_NewsPresentable {
    var title_Color : UIColor{
        return UIColor.black
    }
    
    var title_Font : UIFont {
        return UIFont(name: "Helvetica", size: 25)!
    }
    
    func updateTitleLable(label:UILabel){
        label.text = title
        label.textColor = title_Color
        label.font = title_Font
    }
    
}
