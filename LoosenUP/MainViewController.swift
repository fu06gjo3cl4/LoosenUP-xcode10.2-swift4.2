//
//  SubViewController1.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/6.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit
import FSPagerView
import SnapKit
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController {
    
    fileprivate let sectionTitles = ["Configurations", "Item Size", "Interitem Spacing"]
    fileprivate let configurationTitles = ["Automatic sliding","Infinite"]
    fileprivate let imageNames = ["1.png","2.png","3.jpg","4.png","5.png","6.png","7.png"]
    
    var times_viewDidLayoutSubviews:Int = 0
    var total_height_forscrollview_container : CGFloat = 0
    
    //介面連結區
    @IBOutlet weak var scrollview: UIScrollView!{
        didSet{
//            self.scrollview.delegate = self
        }
    }
    
    @IBOutlet weak var scrollview_container: UIView!{
        didSet{
            for subview in self.scrollview_container.subviews{
                total_height_forscrollview_container = total_height_forscrollview_container + subview.bounds.size.height
            }
            self.scrollview_container.bounds.size.height = total_height_forscrollview_container
            
        }
    }
    
    @IBOutlet weak var imageview_gif: UIImageView!{
        didSet{
            imageview_gif.loadGif(name: "loading_cat")
        }
    }
    
    
    @IBOutlet weak var subview_detect: UIView!{
        didSet{
            
        }
    }
    @IBOutlet weak var effect_container: UIView!{
        didSet{
            
        }
    }
    @IBOutlet weak var effect_collectionView: EffectCollectionView!{
        didSet{
            let rankCell = UINib(nibName: "RankingCollectionCell", bundle: nil)
            self.effect_collectionView.register(rankCell, forCellWithReuseIdentifier: "RankingCollectionCell")
            self.effect_collectionView.dataSource = self.effect_collectionView
            self.effect_collectionView.delegate = self.effect_collectionView
        }
    }
    
    
    @IBOutlet weak var popularity_Container: UIView!
    
    @IBOutlet weak var populartity_collectionView: PopularityCollectionView!{
        didSet{
            let rankCell = UINib(nibName: "RankingCollectionCell", bundle: nil)
            self.populartity_collectionView.register(rankCell, forCellWithReuseIdentifier: "PopularityCollectionCell")
            self.populartity_collectionView.dataSource = self.populartity_collectionView
            self.populartity_collectionView.delegate = self.populartity_collectionView
        }
    }
    
    
    @IBOutlet weak var subview_effect_ranking: UIView!
    @IBOutlet weak var subview_popularity_ranking: UIView!
    @IBOutlet weak var btn_Tired: UIButton!{
        didSet{
            btn_Tired.addborder(color: UIColor.black.cgColor, height: 1.0)
            btn_Tired.addShadow(color: UIColor.black.cgColor, width: 1.0, height: 1.0, radius: 5.0, opacity: 0.5)
            
            btn_Tired.setBackgroundColor(color: Setting.shared.mainColor().cgColor)
            btn_Tired.SetCornerRadius(cornerRadius: 5.0)
        }
    }
    @IBOutlet weak var btn_Relax: UIButton!{
        didSet{
            btn_Relax.addborder(color: UIColor.black.cgColor, height: 1.0)
            btn_Relax.addShadow(color: UIColor.black.cgColor, width: 1.0, height: 1.0, radius: 5.0, opacity: 0.5)
            
            btn_Relax.setBackgroundColor(color: Setting.shared.mainColor().cgColor)
            btn_Relax.SetCornerRadius(cornerRadius: 5.0)
        }
    }
    //介面事件連結
    @IBAction func btn_Tired_Detect(_ sender: Any) {
        print("to tired detect")
        
        let viewcontroller = SelectSituationViewController()
        viewcontroller.title = "情境選擇"
        self.navigationController?.pushViewController(viewcontroller, animated: true)
        
    }
    @IBAction func btn_Relax_Detect(_ sender: Any) {
        print("to relax detect")
    }
    
    @IBOutlet weak var FS_PagerView: FSPagerView!{
        didSet {
            self.FS_PagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
//            self.FS_PagerView.itemSize = self.FS_PagerView.frame.size.applying(CGAffineTransform(scaleX: 0.99, y: 0.99))
            self.FS_PagerView.interitemSpacing = 5.0
            self.FS_PagerView.automaticSlidingInterval = 3.0
            self.FS_PagerView.isInfinite = true
            self.FS_PagerView.transformer = FSPagerViewTransformer(type: .overlap)
        }
    }
    @IBOutlet weak var FS_PageControl: FSPageControl!{
        didSet {
            self.FS_PageControl.numberOfPages = self.imageNames.count
            self.FS_PageControl.contentHorizontalAlignment = .center
            self.FS_PageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
    //畫面切換
    func pushViewController(title:String,viewcontroller:UIViewController){
        viewcontroller.title = title
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @objc func swipe_tabs_left(){
        print("left")
        HomeTabBarController.shared.swipe_tabs_left()
    }
    
    @objc func swipe_tabs_right(){
        print("right")
        HomeTabBarController.shared.swipe_tabs_right()
    }
    
    static let shared = MainViewController()
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationService.setNavBarColor(navigationController: self.navigationController!, color: Setting.shared.mainColor())
        
        // 加入左滑根右滑手勢
        let swipe_left = UISwipeGestureRecognizer(target: self, action: #selector(MainViewController.swipe_tabs_left))
        swipe_left.direction = .left
        self.view.addGestureRecognizer(swipe_left)
        
        let swipe_right = UISwipeGestureRecognizer(target: self, action: #selector(MainViewController.swipe_tabs_right))
        swipe_right.direction = .right
        self.view.addGestureRecognizer(swipe_right)
        
        //觀察佈景主題變數
        Setting.shared.addObserver(self, forKeyPath: "themeType", options: .new, context: nil)
        
        
//        RestfulService.request_get(url: GetUrl.Url,callback: callbacktest)
        RestfulService.request_get(url: GetUrl.Url)
        
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        times_viewDidLayoutSubviews = times_viewDidLayoutSubviews+1
        if(times_viewDidLayoutSubviews == 2){
            // 加入上邊界與下邊界   (加在viewdidload無法正確呈現)
            effect_container.addtopborder(color: UIColor.black.cgColor, height: 3.0)
            effect_container.addbottomborder(color: UIColor.black.cgColor, height: 3.0)
            popularity_Container.addtopborder(color: UIColor.black.cgColor, height: 3.0)
            popularity_Container.addbottomborder(color: UIColor.black.cgColor, height: 3.0)
            
        }
        
        for subview in self.scrollview_container.subviews{
            total_height_forscrollview_container = total_height_forscrollview_container + subview.bounds.size.height
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
//        self.navigationController?.navigationBar.tintColor = Setting.shared.mainColor()
        if keyPath! == "themeType"{
            self.navigationController?.navigationBar.barTintColor = Setting.shared.mainColor()
            btn_Tired.setBackgroundColor(color: Setting.shared.mainColor().cgColor)
            btn_Relax.setBackgroundColor(color: Setting.shared.mainColor().cgColor)
        }
        
    }
}
extension MainViewController: FSPagerViewDelegate,FSPagerViewDataSource{
    
    // MARK:- FSPagerView DataSource
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imageNames.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
//            cell.imageView?.image = UIImage(named: "icon" + String(index+1))
//            cell.textLabel?.text = "第" + String(index+1) + "張"
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = index.description+index.description
        return cell
    }
    
    
    // MARK:- FSPagerView Delegate
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        FS_PagerView.deselectItem(at: index, animated: true)
        FS_PagerView.scrollToItem(at: index, animated: true)
        self.FS_PageControl.currentPage = index
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.FS_PageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.FS_PageControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
    }
    
}

extension MainViewController{
    
    func callbacktest(json:JSON){
        print("callbackfunction was executive")
        print(json)
        
    }
    
}
