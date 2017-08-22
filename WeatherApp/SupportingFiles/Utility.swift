//
//  Utility.swift
//  WeatherApp
//
//  Created by Saylee Pradhan on 8/19/17.
//  Copyright © 2017 Saylee Pradhan. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
    struct DateKeys {
        static let day = "day"
        static let monthName = "monthname_short"
        static let year = "year"
        static let weekday = "weekday"
    }
    class func getImage(url: String) -> Data? {
        let urlStr:URL = URL(string: url)!
        let data: Data?
        do {
            data = try Data.init(contentsOf: urlStr, options: .alwaysMapped)
        }
        catch {
            data = nil
        }
        return data
    }
    
    class func getTempInF(temp: String) -> String? {
        let strings = temp.components(separatedBy: "(")
        return strings[0] 
    }
    class func getDayTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    class func getDateFromJson(dateInfo: [String: Any]) -> String{
        var dateStr = String()
        if let weekday = dateInfo[DateKeys.weekday] {
            dateStr.append("\(weekday), ")
        }
        if let month = dateInfo[DateKeys.monthName] {
            dateStr.append("\(month) ")
        }
        if let date = dateInfo[DateKeys.day] {
            dateStr.append("\(date) ")
        }
        return dateStr
    }
    
    class func getNavBarBGColor() -> UIColor {
        return UIColor(red: 25.0/255.0, green: 25.0/255.0, blue: 25.0/255.0, alpha: 1.0)
    }
}
