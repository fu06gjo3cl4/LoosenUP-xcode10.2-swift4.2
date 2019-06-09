//
//  PersonalQualityViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/4/19.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit
import Segmentio

class PersonalQualityViewController: UIViewController {
    
    
    
    @IBOutlet weak var segmentioView: Segmentio!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SegmentioBuilder.buildSegmentioView(segmentioView: segmentioView, segmentioStyle: SegmentioStyle.onlyLabel)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
