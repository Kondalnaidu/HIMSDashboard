//
//  Views.swift
//  HIMSDashboard
//
//  Created by ATHENTECH INDIA on 17/07/23.
//

import Foundation
import AVKit
import DGCharts
extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
    func setViewCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

}
extension Date {
    func getZeroTime() -> Date{
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let startOfDate = calendar.startOfDay(for: self)
        return startOfDate
    }
     

}
extension String {


    func convertDateString() -> String? {
        return convert(dateString: self, fromDateFormat: "yyyy-MM-dd'T'HH:mm:ssZ", toDateFormat: "yyyy-MM-dd")
    }


    func convert(dateString: String, fromDateFormat: String, toDateFormat: String) -> String? {

        let fromDateFormatter = DateFormatter()
        fromDateFormatter.dateFormat = fromDateFormat

        if let fromDateObject = fromDateFormatter.date(from: dateString) {

            let toDateFormatter = DateFormatter()
            toDateFormatter.dateFormat = toDateFormat

            let newDateString = toDateFormatter.string(from: fromDateObject)
            return newDateString
        }

        return nil
    }

}
 
