//
//  Fatigue_PeriodViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/26.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit
import Charts

class Fatigue_PeriodViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    
    //變數宣告區
    var timer : Timer! //每隔一段時間呼叫
    var yse1 : [ChartDataEntry] = []
    var yse2 : [ChartDataEntry] = []
    var yse3 : [ChartDataEntry] = []
    var counter : Int = 0
    var xval : [String] = []
    var yval : [Double] = []
    var lineChartDataSet_array:[LineChartDataSet] = []
    
    var times : [String]! = ["00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"]
    
    
    @IBOutlet weak var lb_title1: UILabel!{
        didSet{
            lb_title1.setBackgroundColor(color: Setting.shared.mainColor().cgColor)
        }
    }
    
    @IBOutlet weak var lb_title2: UILabel!{
        didSet{
            lb_title2.setBackgroundColor(color: Setting.shared.mainColor().cgColor)
        }
    }
    
    @IBOutlet weak var lb_title3: UILabel!{
        didSet{
            lb_title3.setBackgroundColor(color: Setting.shared.mainColor().cgColor)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChartView.setViewPortOffsets(left: 40, top: 40, right: 40, bottom: 40)
        lineChartView.xAxis.drawGridLinesEnabled = false
//        lineChartView.legend.enabled = false
        lineChartView.chartDescription?.text = ""
        
        
        lineChartView.leftAxis.axisLineWidth = 2.0
        lineChartView.xAxis.axisLineWidth = 2.0
        lineChartView.leftAxis.axisMaximum = 100.0
        lineChartView.leftAxis.axisMinimum = 0.0
        lineChartView.rightAxis.axisMinimum = 0
        lineChartView.rightAxis.axisMaximum = 0
        
        lineChartView.setVisibleXRange(minXRange: 0, maxXRange: 23)
        lineChartView.xAxis.labelPosition = .bottom
//        lineChartView.xAxis.enabled = false
        
        
        
        let xAxis=XAxis()
        let chartFormmater=ChartFormatter()
        
//        for i in 0...23{
//            chartFormmater.stringForValue(Double(i), axis: xAxis)
//        }
        
        xAxis.valueFormatter=chartFormmater
        lineChartView.xAxis.valueFormatter = xAxis.valueFormatter
        
        
        for _ in 0...11{
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
//        lineChartView.setVisibleXRange(minXRange: 0, maxXRange: 23)
        lineChartView.moveViewToX(Double(yse1.count+1))
        
        // Do any additional setup after loading the view.
        let ys1 =  Double(arc4random_uniform(10) + 28)
        let data_entry =  ChartDataEntry(x: Double(yse1.count), y: ys1)
        
        yse1.append(data_entry)
        
        let data = LineChartData()
        let ds1 = LineChartDataSet(values: yse1, label: "本週平均")
        ds1.colors = [NSUIColor.red]
        data.addDataSet(ds1)
        
        let ys2 =  Double(arc4random_uniform(15) + 32)
        let data_entry2 =  ChartDataEntry(x: Double(yse2.count), y: ys2)
        yse2.append(data_entry2)
        
        let ds2 = LineChartDataSet(values: yse2, label: "本月平均")
        ds2.colors = [NSUIColor.blue]
        data.addDataSet(ds2)
        
        let ys3 =  Double(arc4random_uniform(15) + 32)
        let data_entry3 =  ChartDataEntry(x: Double(yse3.count), y: ys3)
        yse3.append(data_entry3)
        
        let ds3 = LineChartDataSet(values: yse3, label: "歷史平均")
        ds3.colors = [NSUIColor.green]
        
        data.addDataSet(ds3)
        data.setDrawValues(false)
        
//        self.lineChartView.point(inside: CGPoint(x: 0.5, y: 0.5), with: nil)
        self.lineChartView.data = data
        self.lineChartView.gridBackgroundColor = NSUIColor.white
        
    }
    
    
}

extension Fatigue_PeriodViewController:IAxisValueFormatter{
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return times[Int(value)]
    }
    
}








