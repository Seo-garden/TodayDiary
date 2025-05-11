//
//  DateFormatter+Extension.swift
//  TodayDiary
//
//  Created by 서정원 on 4/30/25.
//

import Foundation
//MARK: 현재의 날짜를 받아오는 함수를 선언해서 title에 저장하고 싶은데, 해당 메서드를 사용할 일이 잦을 것 같아 extension 으로 확장
extension DateFormatter {
    static let koreanDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter
    }()
    
    static func todayString() -> String {
        return koreanDate.string(from: Date())
    }
}
