//
//  NewChartVC.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 11/02/24.
//

import UIKit
import DGCharts
import Charts
class NewChartVC: UIViewController,ChartViewDelegate {

    @IBOutlet weak var barchatView: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let values = [20.0, 30.0, 40.0, 50.0, 60.0]
        let labels = ["A", "B", "C", "D", "E"]
        barchatView.delegate = self
        setChart(dataPoints: labels, values: values)
     }
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        barchatView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Values")
        let chartData = BarChartData(dataSet: chartDataSet)
        barchatView.xAxis.labelPosition = .top
        barchatView.data = chartData
        
    }

    
  
}
// mark
