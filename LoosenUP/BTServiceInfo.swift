//
//  BTServiceInfo.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/19.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import Foundation
import CoreBluetooth

class BTServiceInfo {
    
    var service: CBService!
    var characteristics: [CBCharacteristic]
    init(service: CBService, characteristics: [CBCharacteristic]) {
        self.service = service
        self.characteristics = characteristics
    }
    
}

