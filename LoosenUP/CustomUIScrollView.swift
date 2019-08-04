//
//  UIScrollView.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2019/8/1.
//  Copyright © 2019 黃麒安. All rights reserved.
//

import UIKit

class CustomUIScrollView: UIView{
    
    var view:UIView!
    var collectionCellsCount = 20
    var totalCellCount = 82
    @objc dynamic var isGoTopBtnActive = false
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            let rankCell = UINib(nibName: "RankingCollectionCell", bundle: nil)
            self.collectionView.register(rankCell, forCellWithReuseIdentifier: "RankingCollectionCell")
//            self.collectionView.dataSource = self
//            self.collectionView.delegate = self
        }
    }
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var contentview: UIView!
    @IBOutlet weak var btnTop: UIButton!{
        didSet{
            btnTop.isEnabled = false
            btnTop.isHidden = true
        }
    }
    @IBOutlet weak var btnBottom: UIButton!{
        didSet {
            btnBottom.isEnabled = false
            btnBottom.isHidden = true
        }
    }
    
    @IBAction func btnTopAction(_ sender: Any) {
        scrollToBottom()
    }
    
    @IBAction func btnBottomAction(_ sender: Any) {
        scrollToTop()
        self.isGoTopBtnActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomUIScrollView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func scrollToBottom(){
        let bottomOffset = CGPoint(x: 0, y: scrollview.contentSize.height - scrollview.bounds.size.height)
        scrollview.setContentOffset(bottomOffset, animated: true)
    }
    
    func scrollToTop(){
        let bottomOffset = CGPoint(x: 0, y: 0)
        scrollview.setContentOffset(bottomOffset, animated: true)
    }
}

extension CustomUIScrollView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionCellsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let rankcell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingCollectionCell", for: indexPath) as! RankingCollectionCell
        rankcell.image_no.image = UIImage(named: "NO")?.withRenderingMode(.alwaysTemplate)
        
        return rankcell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (self.view.frame.width-30)/3, height: (self.view.frame.height-30)/4)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select item at indexPath: \(indexPath.row)" )
    }
}
