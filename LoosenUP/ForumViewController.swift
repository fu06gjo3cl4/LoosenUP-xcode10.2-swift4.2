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
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("cell did deselect")
    }
    
    //highlight or not for backgroundcolor
    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ForumTableCell
        cell.whiteRoundedView.backgroundColor = Const.grayChateau
        print("cell did highlight")
    }
    
    //highlight or not for backgroundcolor
    public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ForumTableCell
        cell.whiteRoundedView.backgroundColor = Const.white
        print("cell did unhighlight")
    }
    
    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        print("cell should highlight")
        return true
    }
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        print("cell row will select")
        return indexPath
    }
    
    public func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        print("cell row will select")
    }
    
    
    
}




