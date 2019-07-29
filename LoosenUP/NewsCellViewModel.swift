////
////  NewsViewModel.swift
////  FocusUp
////
////  Created by 黃麒安 on 2016/2/29.
////  Copyright © 2016年 黃麒安. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//
//class NewsCellViewModel : NewsCellViewModelPresenter {
//    var title:String
//    var datetime:String
//    var detail_btn_image:UIImage
//    var thumbnail_image:UIImage
//
//    init(news:News){
//        title = news.title
//        datetime = news.datetime
//        detail_btn_image = UIImage(named: news.detail_btn_image)!
//        thumbnail_image = UIImage(named: news.thumbnail_image)!
//    }
//
//    func updatedatetimeLable(label:UILabel){
//        label.text = datetime
//        label.textColor = Setting.shared.mainColor()
//    }
//    func updatedetailButton(button:UIButton){
//        button.setImage(detail_btn_image, for: UIControl.State.normal)
//    }
//    func updateImageView(imageview:UIImageView){
//        imageview.image = thumbnail_image
//    }
//    func updateTitleLable(label:UILabel){
//        label.text = title
//        label.textColor = Setting.shared.mainColor()
//    }
//    //或者樣式factory
//}
//
//
//
//class NewsCellViewModel_Type1: NewsCellViewModelPresenter {
//    var title:String
//    var datetime:String
//    var detail_btn_image:UIImage
//    var thumbnail_image:UIImage
//
//    init(news:News){
//        title = news.title
//        datetime = news.datetime
//        detail_btn_image = UIImage(named: news.detail_btn_image)!
//        thumbnail_image = UIImage(named: "RelaxIcon")!
//    }
//    func updatedatetimeLable(label:UILabel){
//        label.text = datetime
//        label.textColor = Setting.shared.mainColor()
////        label.font = datetime_Font
//    }
//    func updatedetailButton(button:UIButton){
//        button.setImage(detail_btn_image, for: UIControl.State.normal)
//    }
//    func updateImageView(imageview:UIImageView){
//        imageview.image = thumbnail_image
//    }
//    func updateTitleLable(label:UILabel){
//        label.text = title
//        label.textColor = Setting.shared.mainColor()
////        label.font = title_Font
//    }
//}
//
//class NewsCellViewModel_Type2: NewsCellViewModelPresenter {
//    var title:String
//    var datetime:String
//    var detail_btn_image:UIImage
//    var thumbnail_image:UIImage
//
//    init(news:News){
//        title = news.title
//        datetime = news.datetime
//        detail_btn_image = UIImage(named: news.detail_btn_image)!
//        thumbnail_image = UIImage(named: "RelaxIcon")!
//    }
//    func updatedatetimeLable(label:UILabel){
//        label.text = datetime
//        label.textColor = Setting.shared.mainColor()
//        //        label.font = datetime_Font
//    }
//    func updatedetailButton(button:UIButton){
//        button.setImage(detail_btn_image, for: UIControl.State.normal)
//    }
//    func updateImageView(imageview:UIImageView){
//        imageview.image = thumbnail_image
//    }
//    func updateTitleLable(label:UILabel){
//        label.text = title
//        label.textColor = Setting.shared.mainColor()
//        //        label.font = title_Font
//    }
//}
//
//class NewsCellViewModel_Type3: NewsCellViewModelPresenter {
//    var title:String
//    var datetime:String
//    var detail_btn_image:UIImage
//    var thumbnail_image:UIImage
//
//    init(news:News){
//        title = news.title
//        datetime = news.datetime
//        detail_btn_image = UIImage(named: news.detail_btn_image)!
//        thumbnail_image = UIImage(named: "RelaxIcon")!
//    }
//    func updatedatetimeLable(label:UILabel){
//        label.text = datetime
//        label.textColor = Setting.shared.mainColor()
//        //        label.font = datetime_Font
//    }
//    func updatedetailButton(button:UIButton){
//        button.setImage(detail_btn_image, for: UIControl.State.normal)
//    }
//    func updateImageView(imageview:UIImageView){
//        imageview.image = thumbnail_image
//    }
//    func updateTitleLable(label:UILabel){
//        label.text = title
//        label.textColor = Setting.shared.mainColor()
//        //        label.font = title_Font
//    }
//}
//protocol NewsCellViewModelPresenter {
//    var title:String{get}
//    var datetime:String{get}
//    var detail_btn_image:UIImage{get}
//    var thumbnail_image:UIImage{get}
//
//    func updateTitleLable(label:UILabel)
//    func updatedatetimeLable(label:UILabel)
//    func updatedetailButton(button:UIButton)
//    func updateImageView(imageview:UIImageView)
//}
////class func generateViewModel() -> NewsCellViewModelPresenter?{
////    switch Setting.shared.getThemeType() {
////    case .OrangeTheme:
////        return NewsCellViewModel_Type1(news: <#T##News#>)
////
////    case .GreenTheme:
////        return NewsCellViewModel_Type2(news: <#T##News#>)
////
////    case .PurpleTheme:
////        return NewsCellViewModel_Type3(news: <#T##News#>)
////
////    default:
////        return NewsCellViewModel_Type1(news: <#T##News#>)
////}
