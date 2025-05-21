//
//  DiaryGoodVC.swift
//  TodayDiary
//
//  Created by 서정원 on 4/30/25.
//

import UIKit

class DiaryGoodVC: UIViewController {
    var inputText: String {
        textView.text
    }
    //MARK: - Property
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "오늘 좋았던 점 혹은 아쉬웠던 점을 작성해보세요 !"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    let textView = UITextView.makeDiaryTextView()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTitleAndTextViewLayout(titleLabel: titleLabel, textView: textView)
    }
    
    private func setupUI() {
        view.backgroundColor = .mainBackgroundColor
    }
}
