//
//  DailyHowVC.swift
//  TodayDiary
//
//  Created by 서정원 on 4/30/25.
//

import UIKit

class DiaryHowTodayVC: UIViewController {
    var inputText: String {
        textView.text
    }
    //MARK: - Property
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "오늘 어떤 하루를 보내셨나요 ?"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    let textView = UITextView.makeDiaryTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        setupUI()
        setupTitleAndTextViewLayout(titleLabel: titleLabel, textView: textView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setupUI() {
        view.backgroundColor = .mainBackgroundColor
    }
}

extension DiaryHowTodayVC: UITextViewDelegate {
    
}
