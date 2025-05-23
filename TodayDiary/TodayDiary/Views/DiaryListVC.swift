//
//  ViewController.swift
//  TodayDiary
//
//  Created by 서정원 on 4/9/25.
//

import CoreData
import UIKit

class DiaryListVC: UIViewController {
    private var diaries: [Entity] = []
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
    
    private lazy var diaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 0
        label.backgroundColor = .labelBackgroundColor
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: 36).isActive = true
        label.layer.cornerRadius = 18
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(writtenVCTapped))
        label.addGestureRecognizer(gesture)
        
        return label
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
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
    }
    
    //plusButton 광클 방지
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updatePlusButtonState()
        loadDiaries()
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
    
    //MARK: - Methods
    private func loadDiaries() {
        diaries = CoreDataManager.shared.fetchDiaries()
        updateUI()
    }
    
    private func updateUI() {
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for diary in diaries {
            if let date = diary.currentDay {
                let dateLabel = createDateLabel(date: date)
                contentStackView.addArrangedSubview(dateLabel)
            }
        }
    }
    
    private func createDateLabel(date: Date) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        label.text = dateFormatter.string(from: date)
        
        label.backgroundColor = .labelBackgroundColor
        label.textAlignment = .center
        label.layer.cornerRadius = 18
        label.layer.masksToBounds = true
        label.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        label.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(writtenVCTapped))
        label.addGestureRecognizer(gesture)
        
        return label
    }

    private func updatePlusButtonState() {
        let hasTodayDiary = CoreDataManager.shared.hasDiaryDate(date: Date())
        plusButton.isEnabled = !hasTodayDiary
        plusButton.alpha = hasTodayDiary ? 0.5 : 1.0 // 비활성화 상태를 시각적으로 표시
    }
    
    // MARK: - Actions
    @objc private func didTapPlusButton() {
        guard !CoreDataManager.shared.hasDiaryDate(date: Date()) else { return }
        let diaryVC = DiaryPageVC()
        
        self.navigationController?.pushViewController(diaryVC, animated: true)
    }
    
    @objc private func writtenVCTapped(_ sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel, let dateText = label.text else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년MM월dd일"
        guard let date = dateFormatter.date(from: dateText) else { print("날짜 파싱 실패"); return }
        
        if let diary = CoreDataManager.shared.fetchDiary(for: date) {
            let readDiaryVC = RUDDiary(diary: diary)
            let navController = UINavigationController(rootViewController: readDiaryVC)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true)
        }
    }
}
