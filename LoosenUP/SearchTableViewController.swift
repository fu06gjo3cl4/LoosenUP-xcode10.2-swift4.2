//
//  searchTableViewController.swift
//  testForLayer
//
//  Created by 黃麒安 on 2019/8/6.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController{
    
    var songs = ["Qnqlwiehfa/", "qpwruRez/xclk", "qythgk", "a/liweur", "[quwoe45123]", "0as9dfi", "a/iewjgl", "agne/jkl", "zrRh;oisdj", "apqweiQor", "[ihbodnvkxz]"]
    
    var searchedSongs = [String]()
    var searchController: MySearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController!.isActive == true {
            return searchedSongs.count
        } else {
            return songs.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = UITableViewCell()
        
        if searchController!.isActive == true {
            cell.textLabel?.text = searchedSongs[indexPath.row]
        } else {
            cell.textLabel?.text = songs[indexPath.row]
        }
        return cell
    }
}

extension SearchTableViewController: UISearchResultsUpdating  {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text!
        searchedSongs = songs.filter { (name) -> Bool in
            return name.contains(searchString)
        }
        tableView.reloadData()
    }
}
