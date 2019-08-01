//
//  EffectCollectionView.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/17.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit

class EffectCollectionView: UICollectionView {
    
//    var ranklist : [rank]()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isScrollEnabled = false
    }

}


extension EffectCollectionView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
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
        
        return rankcell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (self.frame.width-20)/3, height: (self.frame.height-10)/2)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select item at indexPath: \(indexPath.row)" )
        
        if let topController = UIApplication.topViewController(){
            print(topController)
            let viewcontroller = RankingDetailViewController()
            viewcontroller.ranking = indexPath.row
            topController.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
}
