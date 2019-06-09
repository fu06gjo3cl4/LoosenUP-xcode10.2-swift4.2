//
//  HistoryDetailViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/27.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit
import Charts

class HistoryDetailViewController: UIViewController {
    
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    
    //變數宣告區
    var timer : Timer! //每隔一段時間呼叫
    var yse1 : [ChartDataEntry] = []
    var counter : Int = 0
    var xval : [String] = []
    var yval : [Double] = []
    var lineChartDataSet_array:[LineChartDataSet] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChartView.setViewPortOffsets(left: 40, top: 40, right: 40, bottom: 40)
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.legend.enabled = false
        lineChartView.chartDescription?.text = ""
        
        lineChartView.leftAxis.axisLineWidth = 2.0
        lineChartView.xAxis.axisLineWidth = 2.0
        lineChartView.leftAxis.axisMaximum = 100.0
        lineChartView.leftAxis.axisMinimum = 0.0
        lineChartView.rightAxis.axisMinimum = 0
        lineChartView.rightAxis.axisMaximum = 0
        
        lineChartView.setVisibleXRange(minXRange: 0, maxXRange: 8)
        lineChartView.xAxis.labelPosition = .bottom
//        lineChartView.xAxis.enabled = false
        
        for _ in 0...8{
            setChart()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.lineChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func setChart(){
        lineChartView.setVisibleXRange(minXRange: 0, maxXRange: 8)
        lineChartView.moveViewToX(Double(yse1.count+1))
        
        // Do any additional setup after loading the view.
        let ys1 =  Double(arc4random_uniform(15) + 32)
        let data_entry =  ChartDataEntry(x: Double(yse1.count), y: ys1)
        yse1.append(data_entry)
        
        let data = LineChartData()
        let ds1 = LineChartDataSet(values: yse1, label: "Hello")
        ds1.colors = [NSUIColor.red]
        data.addDataSet(ds1)
        
        self.lineChartView.data = data
        self.lineChartView.gridBackgroundColor = NSUIColor.white

    }
    
    
}
