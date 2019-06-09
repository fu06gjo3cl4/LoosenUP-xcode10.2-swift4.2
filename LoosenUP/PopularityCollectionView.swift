//
//  PopularityCollectionView.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/23.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit

class PopularityCollectionView: UICollectionView {
    
}

extension PopularityCollectionView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rankcell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularityCollectionCell", for: indexPath) as! RankingCollectionCell
        
        switch indexPath.row {
        case 0:
            rankcell.image_no.image = UIImage(named: "NO1")
        case 1:
            rankcell.image_no.image = UIImage(named: "NO2")
        case 2:
            rankcell.image_no.image = UIImage(named: "NO3")
        case 3:
            rankcell.image_no.image = UIImage(named: "NO4")
        case 4:
            rankcell.image_no.image = UIImage(named: "NO5")
        default:
            rankcell.image_no.image = UIImage(named: "empty")
        }
        
        
        return rankcell
    }
    
    //use for size
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: self.frame.width*0.25, height: self.frame.height*0.85)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select item at indexPath:" )
        print(indexPath.row)
        
        if let topController = UIApplication.topViewController(){
            print(topController)
            let viewcontroller = RankingDetailViewController()
            viewcontroller.ranking = indexPath.row
            topController.navigationController?.pushViewController(viewcontroller, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor(red: 255.0/255.0,green: 170.0/255.0,blue: 0/255,alpha: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.clear
    }
    
    
    
}



//Use for interspacing
//    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
