//
//  ViewController.swift
//  TodayDiary
//
//  Created by 서정원 on 4/9/25.
//

import UIKit

class DiaryListVC: UIViewController {
    // MARK: - Property
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
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 28
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        
        return button
    }()
    
    private func mockData() {
        for i in 0...30 {
            lazy var label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "탈모빔 \(i)"
            label.numberOfLines = 0
            label.backgroundColor = .labelBackgroundColor
            label.textAlignment = .center
            label.heightAnchor.constraint(equalToConstant: 36).isActive = true
            label.layer.cornerRadius = 18
            label.layer.masksToBounds = true
            label.isUserInteractionEnabled = true
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(writtenVCTapped))
            label.addGestureRecognizer(gesture)
            
            contentStackView.addArrangedSubview(label)
        }   
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mockData()
        setupUI()
        setupNavigation()
    }
    
    //plusButton 광클 방지
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        plusButton.isEnabled = true
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .mainBackgroundColor
        
        view.addSubview(scrollView)
        view.addSubview(plusButton)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            plusButton.widthAnchor.constraint(equalToConstant: 56),
            plusButton.heightAnchor.constraint(equalToConstant: 56),
            plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            plusButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
        
        view.bringSubviewToFront(plusButton)
    }
    
    private func setupNavigation() {
        navigationItem.title = "오늘 일기"
        
        if let navigationBar = navigationController?.navigationBar {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground() // 불투명하게 설정
            appearance.backgroundColor = .mainBackgroundColor
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    // MARK: - Actions    
    @objc private func didTapPlusButton() {
        let diaryVC = DiaryPageVC()
        plusButton.isEnabled = false
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(diaryVC, animated: true)
        }
    }
    
    @objc private func writtenVCTapped() {
        let diaryVC = DiaryWrittenVC()
        diaryVC.modalPresentationStyle = .fullScreen
        present(diaryVC, animated: true)
    }
}
