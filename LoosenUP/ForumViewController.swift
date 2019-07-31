//
//  ForumViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/6.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit

class ForumViewController: UIViewController {
    
    static let shared = ForumViewController()
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var tableview: UITableView!{
        didSet{
            
            let ForumCell = UINib(nibName: "ForumTableCell", bundle: nil)
            self.tableview.register(ForumCell, forCellReuseIdentifier: "ForumTableCell")
            
            self.tableview.allowsSelectionDuringEditing = true
        }
    }
    
    var selectedRow = [IndexPath]()
    var numberOfRows: Int = 10
    var toolView = UIView()
    
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
            HomeTabBarController.shared.hideToolBar()
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "編輯", style: .plain , target: self, action: #selector(self.editBtnAction))
        }else{
            HomeTabBarController.shared.showToolBar()
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain , target: self, action: #selector(self.editBtnAction))
        }
    }
    
    @objc func deleteSelectedRows() {
        self.numberOfRows -= self.selectedRow.count
        let temp = self.selectedRow
        self.selectedRow.removeAll()    //correct value befor datareload
        self.tableview.deleteRows(at: temp, with: .fade)
    }
    
    @objc func swipe_tabs_left(){
        print("left")
        if(tableview.isEditing){
            
        }else{
            HomeTabBarController.shared.swipe_tabs_left()
        }
    }
    
    @objc func swipe_tabs_right(){
        print("right")
        HomeTabBarController.shared.swipe_tabs_right()
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
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let forum = ForumArticle()
        let viewmodel = ForumCellViewModel(forumArticle: forum)

        let cell = self.tableview.dequeueReusableCell(withIdentifier: "ForumTableCell", for: indexPath) as! ForumTableCell
        cell.updateWithPresenter(presenter: viewmodel)
        
        if selectedRow.contains(indexPath) {
            cell.btn.isSelected = true
        }else{
            cell.btn.isSelected = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select item at indexPath:\(indexPath.row)" )
        
        if tableview.isEditing{
            let cell = tableView.cellForRow(at: indexPath) as! ForumTableCell
            cell.buttonSelected()
            if selectedRow.contains(indexPath){
                selectedRow.remove(at: selectedRow.index(of: indexPath)!)
            }else{
                selectedRow.append(indexPath)
            }
            
        }else{
            let viewcontroller = ArticleDetailViewController()
            viewcontroller.title = "文章內容"
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}




