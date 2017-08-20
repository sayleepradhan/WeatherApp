//
//  Utility.swift
//  WeatherApp
//
//  Created by Saylee Pradhan on 8/19/17.
//  Copyright © 2017 Saylee Pradhan. All rights reserved.
//

import Foundation

class Utility {
    
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
}
