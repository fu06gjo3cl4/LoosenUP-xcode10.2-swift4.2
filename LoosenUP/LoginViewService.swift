//
//  LoginViewService.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/6.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginViewService{
    
    //網路請求區塊
    static func Login_Check(account:String,password:String){
        let parameters: Parameters = [
            "Account":account,
            "Password":password
        ]
        
        print("Account : ",account,"Password : ",password)
        
        Alamofire.request(GetUrl.Url + ApiList.Login_Check, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{response in
            if let value = response.result.value {
                let json = JSON(value)
                print(json)
                
            }
            
        }
        
    }
    
    
}

