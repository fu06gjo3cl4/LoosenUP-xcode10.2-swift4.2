//
//  SearchContainerViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/7.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import UIKit

class SearchContainerViewController: UIViewController {
    
    var percentDrivenInteractiveTransition: UIPercentDrivenInteractiveTransition!
    var panGestureRecognizer: UIPanGestureRecognizer!
    let searchTableVC = SearchTableViewController()
    var searchController: MySearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = MySearchController(searchResultsController: searchTableVC)
        searchController?.searchResultsUpdater = searchTableVC
        searchTableVC.searchController = self.searchController
        
        searchController!.searchBar.showsCancelButton = true
        searchController!.searchBar.tintColor = UIColor.white
        searchController!.searchBar.delegate = self
        navigationItem.titleView = searchController?.getsearchBarView()

        navigationItem.setHidesBackButton(true, animated: false)
        searchController!.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController!.hidesNavigationBarDuringPresentation = false
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(panGesture:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    @objc func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        
        let percent = max(panGesture.translation(in: view).x, 0) / view.frame.width
        
        switch panGesture.state {
            
        case .began:
            navigationController?.delegate = self
            _ = navigationController?.popToRootViewController(animated: true)
            
        case .changed:
            if let percentDrivenInteractiveTransition = percentDrivenInteractiveTransition {
                percentDrivenInteractiveTransition.update(percent)
            }
        case .ended:
            let velocity = panGesture.velocity(in: view).x
            
            // Continue if drag more than 50% of screen width or velocity is higher than 1000
            if percent > 0.5 || velocity > 1000 {
                percentDrivenInteractiveTransition.finish()
            } else {
                percentDrivenInteractiveTransition.cancel()
            }
            
        case .cancelled, .failed:
            percentDrivenInteractiveTransition.cancel()
            
        default:
            break
        }
    }

}

extension SearchContainerViewController: UISearchBarDelegate, UISearchControllerDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
}

extension SearchContainerViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return SlideAnimatedTransitioning()
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        navigationController.delegate = nil
        
        if panGestureRecognizer.state == .began {
            percentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
            percentDrivenInteractiveTransition.completionCurve = .easeOut
        } else {
            percentDrivenInteractiveTransition = nil
        }
        
        return percentDrivenInteractiveTransition
    }
}
