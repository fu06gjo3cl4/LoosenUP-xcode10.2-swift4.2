//
//  SelectSituationViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/19.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit

class SelectSituationViewController: UIViewController {
    
    var times_viewDidLayoutSubviews:Int = 0
    
    @IBOutlet weak var workspace_collectionview: UICollectionView!{
        didSet{
            let rankCell = UINib(nibName: "RankingCollectionCell", bundle: nil)
            self.workspace_collectionview.register(rankCell, forCellWithReuseIdentifier: "RankingCollectionCell")
        }
    }
    
    @IBOutlet weak var workcontent_collectionview: UICollectionView!{
        didSet{
            let rankCell = UINib(nibName: "RankingCollectionCell", bundle: nil)
            self.workcontent_collectionview.register(rankCell, forCellWithReuseIdentifier: "RankingCollectionCell")
        }
    }
    
    @objc func toDetect(){
        print("select to detect")
        let viewcontroller = DetectViewController()
        viewcontroller.title = "疲勞檢測"
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //新建按鈕並設定在導航槓右方
        let rightbarbtn = UIBarButtonItem(title: "NEXT",style: UIBarButtonItem.Style.plain,target: self,action: #selector(SelectSituationViewController.toDetect))
        self.navigationItem.rightBarButtonItem = rightbarbtn
        
        UINavigationService.setedgefor_navigationbar(viewcontroller: self)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        times_viewDidLayoutSubviews = times_viewDidLayoutSubviews+1
        workspace_collectionview.addtopborder(color: UIColor.gray.cgColor, height: 3.0)
        workcontent_collectionview.addtopborder(color: UIColor.gray.cgColor, height: 3.0)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    
    
    
}

//extension SelectSituationViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        
//        return 3
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let rankcell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingCollectionCell", for: indexPath)
//
//        
//        return rankcell
//    }
//    //use for size
//    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let size = CGSize(width: self.view.frame.width*0.25, height: self.view.frame.height*0.85)
//        
//        return size
//    }
//}
