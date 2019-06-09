//
//  ForumViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/6.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit

class ForumViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!{
        didSet{
            
            let ForumCell = UINib(nibName: "ForumTableCell", bundle: nil)
            self.tableview.register(ForumCell, forCellReuseIdentifier: "ForumTableCell")
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swipe_left = UISwipeGestureRecognizer(target: self, action: #selector(ForumViewController.swipe_tabs_left))
 
        swipe_left.direction = .left
        self.view.addGestureRecognizer(swipe_left)
        
        let swipe_right = UISwipeGestureRecognizer(target: self, action: #selector(ForumViewController.swipe_tabs_right))
        swipe_right.direction = .right
        self.view.addGestureRecognizer(swipe_right)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func swipe_tabs_left(){
        print("left")
        HomeTabBarController.swipe_tabs_left()
    }
    
    @objc func swipe_tabs_right(){
        print("right")
        HomeTabBarController.swipe_tabs_right()
    }
    
    
}

extension ForumViewController : UITableViewDelegate,UITableViewDataSource{
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 8
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "ForumTableCell", for: indexPath)
        
        
        cell.contentView.backgroundColor = UIColor.clear
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 100))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select item at indexPath:" )
        print(indexPath.row)
        
        
        let viewcontroller = ArticleDetailViewController()
        viewcontroller.title = "文章內容"
        self.navigationController?.pushViewController(viewcontroller, animated: true)
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
    }
    
}




