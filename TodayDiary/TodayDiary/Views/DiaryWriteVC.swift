//
//  DiaryWriteVC.swift
//  TodayDiary
//
//  Created by 서정원 on 4/9/25.
//

import UIKit
import SwiftUI


class DiaryWriteVC: UIViewController {
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let didLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "오늘 하루는 어떻게 보냈나요 ?"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Arial", size: 16)
        textView.backgroundColor = .white
        textView.autocorrectionType = .no                     // 자동 수정 활성화 여부
        textView.spellCheckingType = .no                      // 맞춤법 검사 활성화 여부
        textView.autocapitalizationType = .none               // 자동 대문자 활성화 여부
        textView.isScrollEnabled = true
        textView.clearsOnInsertion = true
        textView.returnKeyType = .default                        // 키보드 엔터키(return, done... )
        textView.keyboardType = UIKeyboardType.namePhonePad   // 키보드 타입
        
        return textView
    }()
    
    private let likeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "오늘 좋았던 점을 적어보세요 !"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private let liketextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Arial", size: 16)
        textView.backgroundColor = .white
        textView.autocorrectionType = .no                     // 자동 수정 활성화 여부
        textView.spellCheckingType = .no                      // 맞춤법 검사 활성화 여부
        textView.autocapitalizationType = .none               // 자동 대문자 활성화 여부
        textView.isScrollEnabled = true
        textView.clearsOnInsertion = true
        textView.returnKeyType = .default                        // 키보드 엔터키(return, done... )
        textView.keyboardType = UIKeyboardType.namePhonePad   // 키보드 타입
        
        return textView
    }()
    
    private let notLikeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "오늘 아쉬웠던 점을 적어보세요 !"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private let notLiketextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Arial", size: 16)
        textView.backgroundColor = .white
        textView.autocorrectionType = .no                     // 자동 수정 활성화 여부
        textView.spellCheckingType = .no                      // 맞춤법 검사 활성화 여부
        textView.autocapitalizationType = .none               // 자동 대문자 활성화 여부
        textView.isScrollEnabled = true
        textView.clearsOnInsertion = true
        textView.returnKeyType = .default                        // 키보드 엔터키(return, done... )
        textView.keyboardType = UIKeyboardType.namePhonePad   // 키보드 타입
        
        return textView
    }()
    
    private let notRepeatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "아쉬웠던 일을 반복하지 않기 위해 할 수 있는 노력을 적어보세요 !"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private let notRepeatTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Arial", size: 16)
        textView.backgroundColor = .white
        textView.autocorrectionType = .no                     // 자동 수정 활성화 여부
        textView.spellCheckingType = .no                      // 맞춤법 검사 활성화 여부
        textView.autocapitalizationType = .none               // 자동 대문자 활성화 여부
        textView.isScrollEnabled = true
        textView.clearsOnInsertion = true
        textView.returnKeyType = .default                        // 키보드 엔터키(return, done... )
        textView.keyboardType = UIKeyboardType.namePhonePad   // 키보드 타입
        
        return textView
    }()
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        
        setupUI()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        textView.resignFirstResponder()
    }
    
    private func setupUI() {
        view.backgroundColor = .mainBackgroundColor
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(didLabel)
        contentView.addSubview(textView)
        contentView.addSubview(likeLabel)
        contentView.addSubview(liketextView)
        contentView.addSubview(notLikeLabel)
        contentView.addSubview(notLiketextView)
        contentView.addSubview(notRepeatLabel)
        contentView.addSubview(notRepeatTextView)
        
        NSLayoutConstraint.activate([
            // 스크롤뷰 제약
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // 콘텐츠뷰 제약
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            // 요소들 제약 - 수직 흐름 유지
            
//            emojiScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            emojiScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            emojiScrollView.heightAnchor.constraint(equalToConstant: 60),
//            
//            emojiStackView.topAnchor.constraint(equalTo: emojiScrollView.topAnchor),
//            emojiStackView.leadingAnchor.constraint(equalTo: emojiScrollView.leadingAnchor),
//            emojiStackView.trailingAnchor.constraint(equalTo: emojiScrollView.trailingAnchor),
//            emojiStackView.bottomAnchor.constraint(equalTo: emojiScrollView.bottomAnchor),
//            emojiStackView.heightAnchor.constraint(equalToConstant: 50),
//            
//            didLabel.topAnchor.constraint(equalTo: emojiScrollView.bottomAnchor, constant: 20),
//            didLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            didLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            textView.topAnchor.constraint(equalTo: didLabel.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 120),
            
            likeLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20),
            likeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            likeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            liketextView.topAnchor.constraint(equalTo: likeLabel.bottomAnchor, constant: 10),
            liketextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            liketextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            liketextView.heightAnchor.constraint(equalToConstant: 120),
            
            notLikeLabel.topAnchor.constraint(equalTo: liketextView.bottomAnchor, constant: 20),
            notLikeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            notLikeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            notLiketextView.topAnchor.constraint(equalTo: notLikeLabel.bottomAnchor, constant: 10),
            notLiketextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            notLiketextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            notLiketextView.heightAnchor.constraint(equalToConstant: 120),
            
            notRepeatLabel.topAnchor.constraint(equalTo: notLiketextView.bottomAnchor, constant: 20),
            notRepeatLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            notRepeatLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            notRepeatTextView.topAnchor.constraint(equalTo: notRepeatLabel.bottomAnchor, constant: 10),
            notRepeatTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            notRepeatTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            notRepeatTextView.heightAnchor.constraint(equalToConstant: 120),
            
            // 마지막 요소와 contentView 바닥 사이의 간격 설정
            notRepeatTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension DiaryWriteVC: UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//#Preview {
//    DiaryWriteVC()
//}
