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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RestfulService.request_get(url: GetUrl.Url,callback: getPostList)
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
