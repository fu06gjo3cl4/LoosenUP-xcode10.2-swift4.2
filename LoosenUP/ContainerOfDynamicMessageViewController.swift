//
//  ContainerOfDynamicMessageViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/12.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import UIKit
import Alamofire
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
    
    var dynamicMessageList = [DynamicMessage]()
    var refreshControl:UIRefreshControl!
    var viewModels = [DynamicMessageCellViewModel]()
    var numberOfRows = 0
    var observers = [NSKeyValueObservation]()
    var userId = 1
    var preCount = 0
    let q = DispatchQueue.global()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    func requestData() {
        let parameters: Parameters = [
            "userId": userId
        ]
        RestfulService.request_get(url: GetUrl.Url,parameters: parameters,callback: getPostList)
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
        return numberOfRows
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
    }
    
}

extension ContainerOfDynamicMessageViewController: UIScrollViewDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("scrollView.contentOffset.y : \(scrollView.contentOffset.y)")
        print((scrollView.contentOffset.y+scrollView.bounds.size.height)>(scrollView.contentSize.height-300))
        
        if((scrollView.contentOffset.y+scrollView.bounds.size.height)>(scrollView.contentSize.height-1200)){
            
            let preNumber = self.tableView.numberOfRows(inSection: 0)
            if preNumber<viewModels.count{
                self.tableView.beginUpdates()
                
                if preNumber+20 <= viewModels.count{
                    numberOfRows = preNumber+20
                    for i in preNumber..<preNumber+20{
                        self.tableView.insertRows(at: [IndexPath(row: i, section: 0)], with: .none)
                    }
                }else{
                    numberOfRows = viewModels.count
                    for i in preNumber..<viewModels.count{
                        self.tableView.insertRows(at: [IndexPath(row: i, section: 0)], with: .none)
                    }
                }
                
                self.tableView.endUpdates()
            }else{
                print("it's end of data")
            }
        }
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
                
                if tableView.numberOfRows(inSection: 0) == 0{
                    numberOfRows = viewModels.count
                    tableView.reloadData()
                }else{
                }
                
                // preload data for use.
                q.sync {
                    userId += 1
                    if(preCount==viewModels.count){
                        
                    }else{
                        preCount = viewModels.count
                        let parameters: Parameters = [
                            "userId": userId
                        ]
                        RestfulService.request_get(url: GetUrl.Url,parameters: parameters,callback: getPostList)
                    }
                }
                
            }
        }
    }
}
