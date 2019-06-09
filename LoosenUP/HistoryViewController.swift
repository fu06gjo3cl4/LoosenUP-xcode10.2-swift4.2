//
//  HistoryViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/26.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    
    @IBOutlet weak var tableview: UITableView!{
        didSet{
            let HistoryCell = UINib(nibName: "HistoryTableCell", bundle: nil)
            self.tableview.register(HistoryCell, forCellReuseIdentifier: "HistoryTableCell")
            tableview.delegate = self
            tableview.dataSource = self
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}

extension HistoryViewController : UITableViewDelegate,UITableViewDataSource{
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 8
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "HistoryTableCell", for: indexPath)
        
        
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
        
        
        let viewcontroller = HistoryDetailViewController()
        viewcontroller.title = "歷史紀錄詳細"
        self.navigationController?.pushViewController(viewcontroller, animated: true)
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
    }

    
    
    
    
}
