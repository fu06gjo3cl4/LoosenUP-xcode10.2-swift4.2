//
//  UIViewExtension.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/6/3.
//  Copyright © 2019年 黃麒安. All rights reserved.
//

import UIKit


extension UIView {
    
    public func addtopborder(view:UIView,color:CGColor,height:CGFloat){
        let topborder = CALayer()
        topborder.backgroundColor = color
        topborder.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        view.layer.addSublayer(topborder)
    }
    
    public func addbottomborder(view:UIView,color:CGColor,height:CGFloat){
        let bottomborder = CALayer()
        bottomborder.backgroundColor = color
        bottomborder.frame = CGRect(x: 0, y: view.frame.height-height, width: view.frame.width, height: height)
        view.layer.addSublayer(bottomborder)
    }
    
    public func addborder(view:UIView,color:CGColor,height:CGFloat,opacity:Float = 1){
        view.layer.borderColor = color
        view.layer.borderWidth = height
        view.layer.opacity = Float(opacity)
    }

    public func addShadow(view:UIView,color:CGColor,width:CGFloat,height:CGFloat,radius:CGFloat,opacity:CGFloat = 1){
        view.layer.shadowColor = color
        view.layer.shadowOffset = CGSize(width: width, height: height)
        view.layer.shadowRadius = radius
        view.layer.shadowOpacity = Float(opacity)
        view.layer.masksToBounds = false
    }
    
    public func SetCornerRadius(view:UIView,cornerRadius:CGFloat){
        view.layer.cornerRadius = cornerRadius
    }
    
    public func setBackgroundColor(view:UIView,color:CGColor){
        view.layer.backgroundColor = color
    }

}

/*
{
    static func addtopborder(view:UIView,color:CGColor,height:CGFloat){
        
        let topborder = CALayer()
        topborder.backgroundColor = color
        topborder.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        view.layer.addSublayer(topborder)
        
    }
    
    static func addbottomborder(view:UIView,color:CGColor,height:CGFloat){
        let bottomborder = CALayer()
        bottomborder.backgroundColor = color
        bottomborder.frame = CGRect(x: 0, y: view.frame.height-height, width: view.frame.width, height: height)
        view.layer.addSublayer(bottomborder)
        
    }
    
    static func addborder(view:UIView,color:CGColor,height:CGFloat){
        view.layer.borderColor = color
        view.layer.borderWidth = height
    }
    
    static func addShadow(view:UIView,color:CGColor,width:CGFloat,height:CGFloat,radius:CGFloat,opacity:CGFloat){
        view.layer.shadowColor = color
        view.layer.shadowOffset = CGSize(width: width, height: height)
        view.layer.shadowRadius = radius
        view.layer.shadowOpacity = Float(opacity)
        view.layer.masksToBounds = false
        
        
        //        let myradius: CGFloat = view.frame.width / 2.0 //change it to .height if you need spread for height
        //        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 2.1 * myradius, height: view.frame.height))
        //
        //        view.layer.shadowPath = shadowPath.cgPath
        
    }
    
    static func SetCornerRadius(view:UIView,cornerRadius:CGFloat){
        view.layer.cornerRadius = cornerRadius
    }
    
    static func setBackgroundColor(view:UIView,color:CGColor){
        view.layer.backgroundColor = color
        
    }

}
 */
