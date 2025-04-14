//
//  FullBarchatVC.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 21/08/23.
//

import UIKit
import DGCharts
class FullBarchatVC: UIViewController {
@IBOutlet weak var barchatView: BarChartView!
@IBOutlet weak var backBtn: UIButton!
var weekBarDataArray = [Int]()
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
          setChart(values: self.weekBarDataArray)
        appDelegate?.myOrientation = .landscape
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGeture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        
      }
     
    @objc  func respondToSwipeGeture(geture: UIGestureRecognizer) {
        if let swipeGeture = geture as? UISwipeGestureRecognizer {
            switch swipeGeture.direction {
            case .right:
                self.navigationController?.popViewController(animated: true)
            default:
                break
            }
        }
    }
func setChart(values: [Int]) {
    barchatView.noDataText = "You need to provide data for the chart."
        //self.setPieChartColor(color: .white)

      var dataEntries: [BarChartDataEntry] = []
      
      for i in 0..<values.count {
        let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
        dataEntries.append(dataEntry)
      }
      
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Athen Tech")
        chartDataSet.colors = ChartColorTemplates.colorful()
//        chartDataSet.colors = colorsOfCharts(numbersOfColor: values.count)

    barchatView.setScaleEnabled(false)
      let chartData = BarChartData(dataSet: chartDataSet)
        
    barchatView.data = chartData
    }
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
      var colors: [UIColor] = []
      for _ in 0..<numbersOfColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
      }
      return colors
    }
@IBAction func backActBtn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
}
    
}
