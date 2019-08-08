//
//  SearchViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/7.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    static let shared = SearchViewController()
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setting.shared.addObserver(self, forKeyPath: "themeType", options: .new, context: nil)
        UINavigationService.setNavBarColor(navigationController: self.navigationController!, color: Setting.shared.mainColor())
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(toSearchVC))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
    }
    
    @objc func toSearchVC(){
        print("toSearchVC")
        let vc = SearchContainerViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SearchViewController {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath! == "themeType"{
            self.navigationController?.navigationBar.barTintColor = Setting.shared.mainColor()
        }
        
    }
    
}
