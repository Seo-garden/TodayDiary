//
//  Date+Extension.swift
//  TodayDiary
//
//  Created by 서정원 on 5/20/25.
//

import Foundation

extension Date {
    var strippedTime: Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: self)
    }
}
