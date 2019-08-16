//
//  Personal_RelaxListViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/26.
//  Copyright © 2017年 黃麒安. All rights reserved.
//
import Foundation
import UIKit

class Personal_RelaxListViewController: UIViewController {
    
    var cellCount: Int = 16
    @IBOutlet weak var collectionView: CustomCollectionView!{
        didSet{
            let rankCell = UINib(nibName: "RankingCollectionCell", bundle: nil)
            self.collectionView.register(rankCell, forCellWithReuseIdentifier: "RankingCollectionCell")
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
    }
    @IBOutlet weak var myview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension Personal_RelaxListViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let rankcell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingCollectionCell", for: indexPath) as! RankingCollectionCell
        
        rankcell.isSelected = false
        collectionView.deselectItem(at: indexPath, animated: true)
        
        return rankcell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (self.collectionView.frame.width-40)/3, height: (self.collectionView.frame.height-10)/2)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select item at indexPath: \(indexPath.row)" )
        
        let cell = collectionView.cellForItem(at: indexPath) as! RankingCollectionCell
        
        if cell.isSelected == true{
            cell.addborder(color: Setting.shared.mainColor().cgColor, height: 1)
        }else{
            cell.addborder(color: UIColor.orange.cgColor, height: 1)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == self.cellCount - 1 ) {
            //Load more data & reload your collection view
            
        }
    }
}

extension Personal_RelaxListViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("collectionView has been scrolled")
    }
}
