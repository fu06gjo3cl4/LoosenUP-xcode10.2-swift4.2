//
//  HomeViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/4.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController {
    //介面連結
    @IBOutlet weak var label: UILabel!
    
    //變數宣告
    var NewsList : [News] = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let callback:([News])->() = callback_SetNewsList
        HomeViewService.GetNewsList(amount: "2",callback: callback)
        
        print(NewsList)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callback_SetNewsList(NewsList:[News]){
        self.NewsList = NewsList
        print(self.NewsList)
        
    }
    
}
