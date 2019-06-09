//
//  ArticleDetailViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/27.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var btn_reply: UIButton!
    
    @IBOutlet weak var btn_collect: UIButton!
    
    @IBOutlet weak var btn_like: UIButton!
    
    var like_count = 0
    var collect_count = 0
    var reply_count = 0
    
    @IBAction func btn_like(_ sender: Any) {
        
        if(like_count == 0){
            self.btn_like.setBackgroundImage(UIImage(named: "Like"), for: UIControlState.normal)
            like_count = like_count + 1
        }else{
            self.btn_like.setBackgroundImage(UIImage(named: "UnLike"), for: UIControlState.normal)
            like_count = like_count - 1
        }
    }
    @IBAction func btn_collect(_ sender: Any) {
        
        if(collect_count == 0){
            self.btn_collect.setBackgroundImage(UIImage(named: "Collect"), for: UIControlState.normal)
            collect_count = collect_count + 1
        }else{
            self.btn_collect.setBackgroundImage(UIImage(named: "UnCollect"), for: UIControlState.normal)
            collect_count = collect_count - 1
        }
    }
    @IBAction func btn_reply(_ sender: Any) {
        
//        if(reply_count == 0){
//            self.btn_reply.setBackgroundImage(UIImage(named: "Like"), for: UIControlState.normal)
//            reply_count = reply_count + 1
//        }else{
//            self.btn_reply.setBackgroundImage(UIImage(named: "UnLike"), for: UIControlState.normal)
//            reply_count = reply_count - 1
//        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
