//
//  detail_btn_NewsPresentable.swift
//  FocusUp
//
//  Created by 黃麒安 on 2016/2/29.
//  Copyright © 2016年 黃麒安. All rights reserved.
//

import Foundation
import UIKit


protocol Detail_btn_NewsPresentable{
    
    var detail_btn_image:UIImage{get}
    
    func updatedetailButton(button:UIButton)
    
}

extension Detail_btn_NewsPresentable{
    
    var detail_btn_image:UIImage{
        return UIImage(named: "More")!
    }
    
    
    
    func updatedetailButton(button:UIButton){
        button.setImage(detail_btn_image, for: UIControl.State.normal)
    }
    
}
