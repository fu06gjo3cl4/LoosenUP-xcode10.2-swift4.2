//
//  RestfulService.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/6/6.
//  Copyright © 2019年 黃麒安. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RestfulService{
    
    //JSONEncoding.default
    static func request_get(url:URLConvertible, parameters:Parameters? = nil,encoding: ParameterEncoding = URLEncoding.default,headers:HTTPHeaders? = nil, callback:@escaping (JSON)->() = {_ in print("default func")}){
        Alamofire.request(url, method: .get, parameters: parameters, encoding: encoding, headers: headers).responseJSON { response in
            if let value = response.result.value {
                let json = JSON(value)
                print("-------------------json data-------------------")
                print(json)
                callback(json)
                print("-------------the end of json data--------------")
            }
        }
    }
    
    static func request_post(url:URLConvertible, parameters:Parameters? = nil,encoding: ParameterEncoding = URLEncoding.default,headers:HTTPHeaders? = nil, callback:@escaping (JSON)->() = {_ in print("default func")}){
        Alamofire.request(url, method: .post, parameters: parameters, encoding: encoding, headers: headers).responseJSON { response in
            if let value = response.result.value {
                let json = JSON(value)
                print("-------------------json data-------------------")
                print(json)
                callback(json)
                print("-------------the end of json data--------------")
            }
        }
    }
    
    static func request_put(url:URLConvertible, parameters:Parameters? = nil,encoding: ParameterEncoding = URLEncoding.default,headers:HTTPHeaders? = nil, callback:@escaping (JSON)->() = {_ in print("default func")}){
        Alamofire.request(url, method: .put, parameters: parameters, encoding: encoding, headers: headers).responseJSON { response in
            if let value = response.result.value {
                let json = JSON(value)
                print("-------------------json data-------------------")
                print(json)
                callback(json)
                print("-------------the end of json data--------------")
            }
        }
    }
    
    static func request_patch(url:URLConvertible, parameters:Parameters? = nil,encoding: ParameterEncoding = URLEncoding.default,headers:HTTPHeaders? = nil, callback:@escaping (JSON)->() = {_ in print("default func")}){
        Alamofire.request(url, method: .patch, parameters: parameters, encoding: encoding, headers: headers).responseJSON { response in
            if let value = response.result.value {
                let json = JSON(value)
                print("-------------------json data-------------------")
                print(json)
                callback(json)
                print("-------------the end of json data--------------")
            }
        }
    }
    
    
}

