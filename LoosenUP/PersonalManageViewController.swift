//
//  PersonalManageViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/26.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit

class PersonalManageViewController: UIViewController {
    
    
    
    @IBOutlet weak var btn_personal_relaxList: UIButton!
    @IBOutlet weak var btn_situation_analysis: UIButton!
    @IBOutlet weak var btn_fatigue_period: UIButton!
    @IBOutlet weak var btn_personal_ranking: UIButton!
    @IBOutlet weak var btn_history: UIButton!
    
    
    @IBAction func to_personal_relaxList(_ sender: Any) {
        print("to personal relax list")
        
        let viewcontroller = Personal_RelaxListViewController()
        viewcontroller.title = "個人化舒緩清單"
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @IBAction func to_situation_analysis(_ sender: Any) {
        print("to situation analysis")
        
        let viewcontroller = Situation_AnalysisViewController()
        viewcontroller.title = "最適工作情境推薦"
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @IBAction func to_fatigue_period(_ sender: Any) {
        print("to fatigue period")
        
        let viewcontroller = Fatigue_PeriodViewController()
        viewcontroller.title = "疲勞時段分析"
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @IBAction func to_personal_ranking(_ sender: Any) {
        print("to personal ranking")
        
        let viewcontroller = PersonalQualityViewController()
        viewcontroller.title = "個人素質分析"
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @IBAction func to_history(_ sender: Any) {
        print("to history")
        
        let viewcontroller = HistoryViewController()
        viewcontroller.title = "歷史紀錄"
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
