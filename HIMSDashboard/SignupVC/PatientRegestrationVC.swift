//
//  PatientRegestrationVC.swift
//  HIMSDashboard
//
//  Created by ATHENTECH INDIA on 19/07/23.
//

import UIKit
import DGCharts
import Charts
class PatientRegestrationVC: UIViewController {
@IBOutlet weak var dateOfbirthBtn: UIButton!
@IBOutlet weak var ageBtn: UIButton!
@IBOutlet weak var selectSalutationFld: UITextField!
@IBOutlet weak var firstNameFld: UITextField!
@IBOutlet weak var lastNameFld: UITextField!
@IBOutlet weak var selectAgeFld: UITextField!
@IBOutlet weak var ageFld: UITextField!
@IBOutlet weak var dateOfBirthFld: UITextField!
@IBOutlet weak var genderFld: UITextField!
@IBOutlet weak var maritalStatusFld: UITextField!
@IBOutlet weak var guardianFld: UITextField!
@IBOutlet weak var selectDoctorFld: UITextField!
@IBOutlet weak var selectProFld: UITextField!
@IBOutlet weak var lineChartView: LineChartView!
var cornerRadius = 6.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let values: [ChartDataEntry] = [
            ChartDataEntry(x: 11.0, y: 10.0),
            ChartDataEntry(x: 150.0, y: 4.0),
            ChartDataEntry(x: 20.0, y: 3.0),
            ChartDataEntry(x: 10.0, y: 1.0),
            ChartDataEntry(x: 200.0, y: 30.0)
                ]

                // Creating a LineChartDataSet
                let dataSet = LineChartDataSet(entries: values, label: "Sample Line Chart")

                // Set different colors for increasing and decreasing values
                dataSet.colors = [NSUIColor.green]
                 
                dataSet.drawValuesEnabled = false

                // Creating a LineChartData object
                let data = LineChartData(dataSet: dataSet)

                // Set the data for the chart view
                lineChartView.data = data

                // Customize the chart view
        lineChartView.chartDescription.text = "My Line Chart"
      //  lineChartView.chartDescription.textAlign = .center
        lineChartView.chartDescription.font = UIFont.systemFont(ofSize: 16.0)

                // Customize the legend
                let legend = lineChartView.legend
                legend.enabled = true
                legend.horizontalAlignment = .center
                legend.verticalAlignment = .bottom
                legend.orientation = .horizontal
                legend.drawInside = false

                // Optionally, customize the xAxis and yAxis
                let xAxis = lineChartView.xAxis
                xAxis.labelPosition = .bottom

                let leftAxis = lineChartView.leftAxis
                leftAxis.labelPosition = .outsideChart
                leftAxis.spaceTop = 0.1
                leftAxis.spaceBottom = 0.1

                let rightAxis = lineChartView.rightAxis
                rightAxis.enabled = false
//
        
//        let values = [32,50,10,300,500]
//        self.setLineChart(values: values)
        
        
      //  setupDesign()
     }
         
    func setupDesign() {
        self.dateOfbirthBtn.setTitle("", for: .normal)
        self.ageBtn.setTitle("", for: .normal)
        selectSalutationFld.textFieldCornerRadius(radius: cornerRadius)
        firstNameFld.textFieldCornerRadius(radius: cornerRadius)
        lastNameFld.textFieldCornerRadius(radius: cornerRadius)
        selectAgeFld.textFieldCornerRadius(radius: cornerRadius)
        ageFld.textFieldCornerRadius(radius: cornerRadius)
        dateOfBirthFld.textFieldCornerRadius(radius: cornerRadius)
        genderFld.textFieldCornerRadius(radius: cornerRadius)
        maritalStatusFld.textFieldCornerRadius(radius: cornerRadius)
        guardianFld.textFieldCornerRadius(radius: cornerRadius)
        selectDoctorFld.textFieldCornerRadius(radius: cornerRadius)
        selectProFld.textFieldCornerRadius(radius: cornerRadius)
 
        
    }
    func setLineChart(values:[Int]) {
              
        var entrys = [ChartDataEntry]()
        for x in 0..<values.count {
            print(x)
            entrys.append(ChartDataEntry(x: Double(values[x]), y: Double(values[x])))
        }
        let lineChartDataSet = LineChartDataSet(entries: entrys, label: "Athen Tech")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        
       // lineChartDataSet.colors = colorsOfCharts(numbersOfColor: values.count)//[NSUIColor.blue] // Line color
       // lineChartDataSet.circleColors = colorsOfCharts(numbersOfColor: values.count)//[NSUIColor.blue] // Circle
       // lineChartDataSet.drawFilledEnabled = true // Enable filling
       // lineChartView.xAxis.labelPosition = .bottom
        //lineChartView.leftAxis.axisMinimum = 10

        

        
        lineChartView.data = lineChartData
        
        let legend = lineChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .center
        legend.verticalAlignment = .bottom
        legend.orientation = .horizontal
        legend.drawInside = false

        // Optionally, customize the xAxis and yAxis
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom

        let leftAxis = lineChartView.leftAxis
        leftAxis.labelPosition = .outsideChart
        leftAxis.spaceTop = 0.1
        leftAxis.spaceBottom = 0.1

        let rightAxis = lineChartView.rightAxis
        rightAxis.enabled = false


             
        
         lineChartView.xAxis.labelCount = values.count
        
     
        
    }
}
