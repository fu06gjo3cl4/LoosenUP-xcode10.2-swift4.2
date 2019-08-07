//
//  MySearchController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/7.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import Foundation
import UIKit

public class MySearchController: UISearchController {
    
    func getsearchBarView()->SearchBarContainerView{
        let searchBarContainer = SearchBarContainerView(customSearchBar: searchBar)
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        return searchBarContainer
    }
    
}
