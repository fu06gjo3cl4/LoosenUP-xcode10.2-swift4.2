//
//  RandomData.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/15.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import Foundation
import UIKit

class RandomData {
    
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABC \nDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
//    static func randomImage()->UIImage{
//
//    }
    
    
    
    
}
