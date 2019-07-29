//
//  DetectViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/19.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit
import CoreBluetooth
import Charts

class DetectViewController: UIViewController , CBCentralManagerDelegate ,CBPeripheralDelegate{
    
    //介面連結區
    //頂部介面連結
    @IBOutlet weak var lb_work_space: UILabel!
    @IBOutlet weak var lb_work_content: UILabel!
    @IBOutlet weak var btn_connect: UIButton!
    @IBOutlet weak var lb_statue: UILabel!
    //圖表介面連結
    @IBOutlet weak var view_lineChart: LineChartView!
    
    //底部介面連結
    @IBOutlet weak var lb_detect_time: UILabel!
    @IBOutlet weak var lb_tired_degree: UILabel!
    @IBOutlet weak var lb_DetectTime: UILabel!
    @IBOutlet weak var lb_TiredValue: UILabel!
    
    @IBOutlet weak var view_detect_time: UIView!{
        didSet{
            view_detect_time.SetCornerRadius(view: view_detect_time, cornerRadius: 5.0)
        }
    }
    @IBOutlet weak var view_tired_degree: UIView!{
        didSet{
            view_tired_degree.SetCornerRadius(view: view_tired_degree, cornerRadius: 5.0)
        }
    }
    
    @IBOutlet weak var btn_start_detect: UIButton!{
        didSet{
            btn_start_detect.setBackgroundColor(view: btn_start_detect, color: Setting.shared.mainColor().cgColor)
            btn_start_detect.SetCornerRadius(view: btn_start_detect, cornerRadius: 5.0)
        }
    }
    @IBOutlet weak var btn_finish_detect: UIButton!{
        didSet{
            btn_finish_detect.setBackgroundColor(view: btn_finish_detect, color: Setting.shared.mainColor().cgColor)
            btn_finish_detect.SetCornerRadius(view: btn_finish_detect, cornerRadius: 5.0)
        }
    }
    
    @IBAction func btn_start_detect(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(DetectViewController.setchart), userInfo: nil, repeats: true)
    }
    
    @IBAction func btn_finish_detect(_ sender: Any) {
    }
    
    
    
    //變數宣告區
    var CM : CBCentralManager!
    var TargetPeripheral :CBPeripheral!
    var TargetCharacteristic : CBCharacteristic!
    var connectedperipheral : CBPeripheral!
    var btServices : [BTServiceInfo]!
    
    var BTPeripheral:[CBPeripheral] = [] //  儲存掃瞄到的 peripheral 物件
    var BTIsConnectable: [Int] = [] //  儲存各個藍芽裝置是否可連線
    var BTRSSI:[NSNumber] = [] // 儲存各個藍芽裝置的訊號強度
    
    var signal_Value : [CGFloat] = []   //儲存所有訊號資料
    var valueForPresent : [CGFloat] = []    //顯示用的訊號數值
    var timer : Timer! //每隔一段時間呼叫
    var yse1 : [ChartDataEntry] = []
    var counter : Int = 0
    var xval : [String] = []
    var yval : [Double] = []
    var lineChartDataSet_array:[LineChartDataSet] = []
    
    var times_viewDidLayoutSubviews:Int = 0
    
    @IBOutlet weak var label: UILabel!
    @IBAction func btn_Stop(_ sender: Any) {
        print("stop scan")
        print(TargetPeripheral!)
        CM!.stopScan()
    }
    @IBAction func btn_Scan(_ sender: Any) {
        print("scanning")
        CM!.scanForPeripherals(withServices: nil, options: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Setting.shared.addObserver(self, forKeyPath: "themeType", options: .new, context: nil)
        
        CM = CBCentralManager(delegate: self, queue: nil)
        btServices = []
        //設定uiview與navigationbar的邊緣。避免覆蓋uiview內容
        UINavigationService.setedgefor_navigationbar(viewcontroller: self)

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(DetectViewController.settestchart), userInfo: nil, repeats: true)
        
        view_lineChart.setViewPortOffsets(left: 40, top: 40, right: 40, bottom: 40)
        view_lineChart.xAxis.drawGridLinesEnabled = false
        view_lineChart.legend.enabled = false
        view_lineChart.chartDescription?.text = ""
        
        view_lineChart.leftAxis.axisLineWidth = 2.0
        view_lineChart.leftAxis.axisMaximum = 1000.0
        view_lineChart.leftAxis.axisMinimum = 0.0
        view_lineChart.rightAxis.axisMinimum = 0
        view_lineChart.rightAxis.axisMaximum = 0
        
        view_lineChart.setVisibleXRange(minXRange: 0, maxXRange: 8)
        view_lineChart.xAxis.enabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view_lineChart.animate(xAxisDuration: 0.0, yAxisDuration: 1.5)
    }
    
    func initchart(){
        
        view_lineChart.setVisibleXRange(minXRange: 0, maxXRange: 8)
        view_lineChart.moveViewToX(Double(yse1.count+1))
        
        // Do any additional setup after loading the view.
        let ys1 =  Double(0.0)
        let data_entry =  ChartDataEntry(x: Double(yse1.count), y: ys1)
        yse1.append(data_entry)
        
        let data = LineChartData()
        let ds1 = LineChartDataSet(values: yse1, label: "Hello")
        ds1.colors = [NSUIColor.red]
        data.addDataSet(ds1)
        
        self.view_lineChart.data = data
        self.view_lineChart.gridBackgroundColor = NSUIColor.white
        
    }
    
    @objc func settestchart(){
         
        view_lineChart.setVisibleXRange(minXRange: 0, maxXRange: 8)
        view_lineChart.moveViewToX(Double(yse1.count+1))
        
        // Do any additional setup after loading the view.
        let ys1 =  Double(arc4random_uniform(100) + 32)
        let data_entry =  ChartDataEntry(x: Double(yse1.count), y: ys1)
        yse1.append(data_entry)
        
        let data = LineChartData()
        let ds1 = LineChartDataSet(values: yse1, label: "Hello")
        ds1.colors = [NSUIColor.red]
        ds1.drawCirclesEnabled = false
        data.addDataSet(ds1)
        
        self.view_lineChart.data = data
        self.view_lineChart.gridBackgroundColor = NSUIColor.white
    
    }
    
    @objc func setchart(){
        view_lineChart.setVisibleXRange(minXRange: 0, maxXRange: 8)
        view_lineChart.moveViewToX(Double(yse1.count+1))
        
        // Do any additional setup after loading the view.
        valueForPresent.append(signal_Value.last!)
        let data_entry =  ChartDataEntry(x: Double(valueForPresent.count), y: Double(valueForPresent.last!))
        yse1.append(data_entry)
        
        let data = LineChartData()
        let ds1 = LineChartDataSet(values: yse1, label: "Hello")
        ds1.colors = [NSUIColor.red]
        data.addDataSet(ds1)
        
        self.view_lineChart.data = data
        self.view_lineChart.gridBackgroundColor = NSUIColor.white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        times_viewDidLayoutSubviews = times_viewDidLayoutSubviews+1
        if(times_viewDidLayoutSubviews == 2){
            self.view_lineChart.addtopborder(view: self.view_lineChart, color: UIColor.black.cgColor, height: 3.0)
            self.view_lineChart.addbottomborder(view: self.view_lineChart, color: UIColor.black.cgColor, height: 3.0)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func testchart(){
        view_lineChart.setVisibleXRange(minXRange: 0, maxXRange: 15)
        let value = yval.count + 1
        view_lineChart.moveViewToX(Double(value))
        let diceRoll = Int(arc4random_uniform(100) + 1)
        xval.append(String("") )
        yval.append(Double(diceRoll))
        setChart(dataPoints: xval, values: yval)
    }
    
    //設定圖表
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
//        var lineChartDataSet_array:[LineChartDataSet] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
            
            
            
        }
//        let test = LineChartDataSet(values: <#T##[ChartDataEntry]?#>, label: <#T##String?#>)
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "")
        lineChartDataSet.mode = LineChartDataSet.Mode(rawValue: lineChartDataSet.mode.rawValue)!
        lineChartDataSet.circleRadius = 1.0
        lineChartDataSet.drawValuesEnabled = false
        lineChartDataSet.lineWidth = 5
        
        lineChartDataSet_array.append(lineChartDataSet)

        
//        IChartDataSet(dataEntries)
        
//        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "")
//        
//        lineChartDataSet.drawCubicEnabled = true
//        lineChartDataSet.circleRadius = 1.0
//        lineChartDataSet.drawValuesEnabled = false
//        lineChartDataSet.lineWidth = 5
        
//        LineChartData(dataSets: <#T##[IChartDataSet]?#>)
        
//        let linechartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        let linechartData = LineChartData(dataSets: lineChartDataSet_array)
        
        
        view_lineChart.data = linechartData
        
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        
        if #available(iOS 10.0, *) {
            switch central.state {
            case CBManagerState.unknown:
                print("BT unknown")
                break
            case CBManagerState.unsupported:
                print("BT unsupported")
                break
            case CBManagerState.unauthorized:
                print("BT unauthorized")
                break
            case CBManagerState.resetting:
                print("BT resetting")
                break
            case CBManagerState.poweredOff:
                print("BT powered off")
                break
            case CBManagerState.poweredOn:
                print("BT powered on")
                break
                //        default:
                //            print("NONE")
                //            break
            }
        } else {
            // Fallback on earlier versions
            switch central.state {
            case .unknown:
                print("BT unknown")
                break
            case .unsupported:
                print("BT unsupported")
                break
            case .unauthorized:
                print("BT unauthorized")
                break
            case .resetting:
                print("BT resetting")
                break
            case .poweredOff:
                print("BT powered off")
                break
            case .poweredOn:
                print("BT powered on")
                break
            }
        }
        
        
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if(peripheral.name == "HMSoft"){
            TargetPeripheral = peripheral
            print("取得目標藍芽模組")
            connectPeripheral()
        }
        
        //        let temp = BTPeripheral.filter { (pl) -&gt; //; Bool in
        //            return pl.name == peripheral.name
        //        }
        
        //        if temp.count == 0 {
        BTPeripheral.append(peripheral)
        BTRSSI.append(RSSI)
        BTIsConnectable.append(Int((advertisementData[CBAdvertisementDataIsConnectable]! as AnyObject).description)!)
        //        }
        
    }
    
    func connectPeripheral(){
        TargetPeripheral!.delegate = self
        print(TargetPeripheral!.state)
        CM!.delegate = self
        CM!.connect(TargetPeripheral!, options: nil)
        print(TargetPeripheral!.state)
        
        
        if (TargetPeripheral!.state == CBPeripheralState.connecting) {
            print("change state")
//            label.text = "Connecting"
            
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if TargetPeripheral!.state == CBPeripheralState.connected {
//            label.text = "Connected"
            btn_connect.setBackgroundImage(UIImage(named:"Connected"), for: UIControl.State.normal)
            lb_statue.text = "已連接"
            TargetPeripheral.discoverServices(nil)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        for serviceObj in peripheral.services! {
            let service:CBService = serviceObj
            let isServiceIncluded = self.btServices.filter({(item : BTServiceInfo)-> Bool in
                return item.service.uuid == service.uuid
            }).count
            if isServiceIncluded == 0 {
                btServices.append(BTServiceInfo(service: service, characteristics: []))
            }
            
            peripheral.discoverCharacteristics(nil, for: service)
            
        }
        
        for item in btServices {
            print(item)
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        let serviceCharacteristics = service.characteristics
        for item in btServices {
            if item.service.uuid == service.uuid {
                item.characteristics = serviceCharacteristics!
                
                for charater in item.characteristics{
                    print(charater.properties.intersection(CBCharacteristicProperties.read))
                    
                    if(charater.service.peripheral.name == "HMSoft"){
                        print("right one")
                        TargetPeripheral.setNotifyValue(true, for: charater)
                    }
                    
                    TargetCharacteristic = charater
                    //                    TargetPeripheral.readValue(for: TargetCharacteristic)
                }
                
                
                break
            }
        }
        
        for item in btServices {
            print(item)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let value = characteristic.value {
            
            let log = String(data: value, encoding: String.Encoding.utf8) as String?
            print(log!)
            if let n = NumberFormatter().number(from: log!) {
                let f = CGFloat(truncating: n)
                signal_Value.append(f)
            }
            
        }
    }
    
    
    
}


extension DetectViewController{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        btn_start_detect.setBackgroundColor(view: btn_start_detect, color: Setting.shared.mainColor().cgColor)
        btn_finish_detect.setBackgroundColor(view: btn_finish_detect, color: Setting.shared.mainColor().cgColor)
//        lb_TiredValue.textColor = Setting.shared.mainColor()
        
        
    }
}
