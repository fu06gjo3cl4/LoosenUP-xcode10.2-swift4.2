//
//  ChartFormatter.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/28.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import Foundation
import Charts


class ChartFormatter: NSObject,IAxisValueFormatter {
    var times : [String]! = ["00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"]
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return times[Int(value)]
    }
    
}
