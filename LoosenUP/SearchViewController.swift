//
//  SearchViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/7.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationService.setNavBarColor(navigationController: self.navigationController!, color: Setting.shared.mainColor())
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(toSearchVC))
        
    }
    
    @objc func toSearchVC(){
        print("toSearchVC")
        let vc = SearchContainerViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
