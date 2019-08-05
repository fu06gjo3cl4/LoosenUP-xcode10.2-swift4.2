//
//  CustomCollectionView.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/5.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import UIKit

class CustomCollectionView: UICollectionView {
    
    //    var ranklist : [rank]()
    var cellCount: Int = 16
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}


extension CustomCollectionView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let rankcell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingCollectionCell", for: indexPath) as! RankingCollectionCell
        
        switch indexPath.row {
        case 0:
            rankcell.image_no.image = UIImage(named: "NO")?.withRenderingMode(.alwaysTemplate)
        case 1:
            rankcell.image_no.image = UIImage(named: "NO")?.withRenderingMode(.alwaysTemplate)
        case 2:
            rankcell.image_no.image = UIImage(named: "NO")?.withRenderingMode(.alwaysTemplate)
        case 3:
            rankcell.image_no.image = UIImage(named: "NO")?.withRenderingMode(.alwaysTemplate)
        case 4:
            rankcell.image_no.image = UIImage(named: "NO")?.withRenderingMode(.alwaysTemplate)
        default:
            rankcell.image_no.image = UIImage(named: "NO")?.withRenderingMode(.alwaysTemplate)
        }
        
        rankcell.isSelected = false
        collectionView.deselectItem(at: indexPath, animated: true)

        return rankcell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (self.frame.width-20)/3, height: (self.frame.height-10)/2)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select item at indexPath: \(indexPath.row)" )
        
        let cell = collectionView.cellForItem(at: indexPath) as! RankingCollectionCell
        cell.addborder(view: cell, color: UIColor.orange.cgColor, height: 1)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == self.cellCount - 1 ) {
            //Load more data & reload your collection view
            self.cellCount += 20
            self.reloadData()
            
            for constraint in self.constraints {
                if constraint.identifier == "heightOfCollectionView" {
                    constraint.constant = self.collectionViewLayout.collectionViewContentSize.height
                }
            }
            self.layoutIfNeeded()

        }
    }
}
