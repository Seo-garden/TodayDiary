//
//  UITextView+Factory.swift
//  TodayDiary
//
//  Created by 서정원 on 5/11/25.
//

import UIKit

extension UITextView {
    static func makeDiaryTextView() -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Arial", size: 16)
        textView.backgroundColor = .mainBackgroundColor
        textView.autocorrectionType = .no                     // 자동 수정 활성화 여부
        textView.spellCheckingType = .no                      // 맞춤법 검사 활성화 여부
        textView.autocapitalizationType = .none               // 자동 대문자 활성화 여부
        textView.isScrollEnabled = true
        textView.clearsOnInsertion = true
        textView.keyboardType = UIKeyboardType.namePhonePad   // 키보드 타입
        textView.isUserInteractionEnabled = true
        
        textView.resignFirstResponder()
        
        return textView
        
    }
}
