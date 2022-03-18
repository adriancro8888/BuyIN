//
//  Date.swift
//  BuyIN
//
//  Created by apple on 3/16/22.
//

import Foundation
class DateFormatterClass {
    static func dateFormatter(date : Date)-> String {
       
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd,yyyy, HH:mm:ss"
        let str = dateFormatter.string(from: date)
        return str
    }
}
