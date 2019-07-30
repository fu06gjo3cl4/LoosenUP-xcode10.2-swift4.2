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
            
            self.tableview.allowsSelectionDuringEditing = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setting.shared.addObserver(self, forKeyPath: "themeType", options: .new, context: nil)
        
        UINavigationService.setNavBarColor(navigationController: self.navigationController!, color: Setting.shared.mainColor())
        
        let swipe_left = UISwipeGestureRecognizer(target: self, action: #selector(ForumViewController.swipe_tabs_left))
 
        swipe_left.direction = .left
        self.view.addGestureRecognizer(swipe_left)
        
        let swipe_right = UISwipeGestureRecognizer(target: self, action: #selector(ForumViewController.swipe_tabs_right))
        swipe_right.direction = .right
        self.view.addGestureRecognizer(swipe_right)
        
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "編輯", style: .plain , target: self, action: #selector(self.editBtnAction))

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @objc func editBtnAction(){
        self.tableview.setEditing(!tableview.isEditing, animated: true)
        if (!tableview.isEditing) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "編輯", style: .plain , target: self, action: #selector(self.editBtnAction))
        }else{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain , target: self, action: #selector(self.editBtnAction))
        }
    }
    
    @objc func swipe_tabs_left(){
        print("left")
        HomeTabBarController.swipe_tabs_left()
    }
    
    @objc func swipe_tabs_right(){
        print("right")
        HomeTabBarController.swipe_tabs_right()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        self.navigationController?.navigationBar.barTintColor = Setting.shared.mainColor()
    }
}

extension ForumViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let forum = ForumArticle()
        let viewmodel = ForumCellViewModel(forumArticle: forum)

        let cell = self.tableview.dequeueReusableCell(withIdentifier: "ForumTableCell", for: indexPath) as! ForumTableCell
        cell.updateWithPresenter(presenter: viewmodel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select item at indexPath:\(indexPath.row)" )
        
        if tableview.isEditing{
            let cell = tableView.cellForRow(at: indexPath) as! ForumTableCell
            cell.buttonSelected()
        }else{
            let viewcontroller = ArticleDetailViewController()
            viewcontroller.title = "文章內容"
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("cell did deselect")
    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        print("cell did highlight")
        if tableview.isEditing{
            
        }else{
            let cell = tableView.cellForRow(at: indexPath) as! ForumTableCell
            cell.whiteRoundedView.backgroundColor = Const.grayChateau
        }
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        print("cell did unhighlight")
        if tableview.isEditing{
            
        }else{
            let cell = tableView.cellForRow(at: indexPath) as! ForumTableCell
            cell.whiteRoundedView.backgroundColor = Const.white
        }
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        print("cell should highlight")
        return true
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        print("cell row will select")
        return indexPath
    }

    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        print("cell row will select")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}




