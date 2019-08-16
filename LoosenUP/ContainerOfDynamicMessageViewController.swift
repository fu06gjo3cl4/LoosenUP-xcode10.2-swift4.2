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
    var viewModels = [DynamicMessageCellViewModel]()
    var observers = [NSKeyValueObservation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        
        refreshControl.addTarget(self, action: #selector(loadData), for: UIControl.Event.valueChanged)
        
        RestfulService.request_get(url: GetUrl.Url,callback: getPostList)
        
    }
    
    @objc func loadData(){
        
        // 延遲讀取模擬網路延遲效果
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()

        }
    }
    
}

extension ContainerOfDynamicMessageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dynamicMessageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "DynamicMessageTableCell", for: indexPath) as! DynamicMessageTableCell
        
        cell.presenter = viewModels[indexPath.row]
        cell.updateWithPresenter()
        cell.fatherTableView = self.tableView
        cell.indexPath = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableCell of indexpath: \(indexPath.row)")
        print("viewModel of indexpath: \(indexPath.row)")
        print(viewModels[indexPath.row].body)
        // if cell's height is no change. can only change viewModel's data to update(already binding value).
//        self.viewModels[indexPath.row].body = RandomData.randomString(length: 200)// "mynewtext for body" 
//        self.dynamicTableView.reloadRows(at: [indexPath], with: .none)
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
            viewModels.append(DynamicMessageCellViewModel(dynamicMessage: dynamicMessage))
            
            if i == json.count-1{
                tableView.reloadData()
                print("over")
            }
        }
        
    }
    
}
