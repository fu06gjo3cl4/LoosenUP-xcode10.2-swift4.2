//
//  ContainerOfDynamicMessageViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/12.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import UIKit
import SwiftyJSON

class ContainerOfDynamicMessageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            
            let MessageCell = UINib(nibName: "DynamicMessageTableCell", bundle: nil)
            tableView.register(MessageCell, forCellReuseIdentifier: "DynamicMessageTableCell")
        }
    }
    
//    var dataModelList = 10  //[DataModel]()
    var dynamicMessageList = [DynamicMessage]()
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        
        refreshControl.addTarget(self, action: #selector(loadData), for: UIControl.Event.valueChanged)
        
        RestfulService.request_get(url: GetUrl.Url,callback: getPostList)
        
    }
    
    @objc func loadData(){
        
        // 這邊我們用一個延遲讀取的方法，來模擬網路延遲效果（延遲3秒）
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            // 停止 refreshControl 動畫
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
//            // 新建5筆假資料
//            for _ in 1...5 {
//                self.data.append(self.data.count + 1)
//                self.myTableView.insertRows(at: [[0,self.data.count - 1]], with: UITableViewRowAnimation.fade)
//            }
//            // 滾動到最下方最新的 Data
//            self.myTableView.scrollToRow(at: [0,self.data.count - 1], at: UITableViewScrollPosition.bottom, animated: true)
        }
    }
}

extension ContainerOfDynamicMessageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dynamicMessageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "DynamicMessageTableCell", for: indexPath) as! DynamicMessageTableCell
        let model = dynamicMessageList[indexPath.row]
        var viewModel = DynamicMessageCellViewModel(dynamicMessage: model)
        cell.updateWithPresenter(presenter: viewModel)
        
        return cell
    }
    
    

    
}


extension ContainerOfDynamicMessageViewController{
    
    func getPostList(json:JSON){
        print("callbackfunction was executive")
        print(json)
        
        for i in 0..<json.count{
            let dynamicMessage = DynamicMessage()
            dynamicMessage.id = json[i]["id"].stringValue
            dynamicMessage.userId = json[i]["userId"].stringValue
            dynamicMessage.title = json[i]["title"].stringValue
            dynamicMessage.body = json[i]["body"].stringValue
            dynamicMessage.avatar = json[i]["avatar_imageUrl"].stringValue
            dynamicMessage.image_Urls = json[i]["image_Urls"].arrayValue.map{$0.stringValue}
            dynamicMessageList.append(dynamicMessage)
            if i == json.count-1{
                tableView.reloadData()
                print("over")//reloadData()
            }
        }
        
        
        
        //        var NewsList : [News] = [News]()
        
        //        for i in 0...json.count{
        //
        ////            var news = News()
        ////            news.title = json["NewsTitle"].stringValue
        ////            news.datetime = json["NewsTime"].stringValue
        ////            news.content = json["NewsContent"].stringValue
        ////
        ////            NewsList.append(news)
        //
        //        }
        
    }
    
}
