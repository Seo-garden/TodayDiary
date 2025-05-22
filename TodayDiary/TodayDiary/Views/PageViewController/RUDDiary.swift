//
//  DiaryWrittenVC.swift
//  TodayDiary
//
//  Created by 서정원 on 4/29/25.
//

import CoreData
import UIKit

class RUDDiary: UIPageViewController {
    private var pages: [UIViewController] = []
    private var currentIndex: Int = 0
    private let diary: Entity
    
    private let emojiPage = DiaryEmojiVC()
    private let howTodayPage = DiaryHowTodayVC()
    private let goodPointPage = DiaryGoodVC()
    private let improvementPage = DiaryImprovementVC()
    
    private var isEditMode: Bool = false {
        didSet {
            updateNavigationBar()
            updatePagesEditMode()
        }
    }
    
    private lazy var deleteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(deleteButtonTapped))
        button.tintColor = .red
        return button
    }()
    
    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        button.tintColor = .black
        return button
    }()
    
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeButtonTapped))
        button.tintColor = .black
        return button
    }()
    
    private lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(editButtonTapped))
        button.tintColor = .black
        return button
    }()
    
    init(diary: Entity) {
        self.diary = diary
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        
        setupNavigation()
        setupPages()
        configurePages()
    }
    
    private func setupNavigation() {
        view.backgroundColor = .mainBackgroundColor
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = editButton
        
        if let date = diary.currentDay {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            title = dateFormatter.string(from: date)
        }
    }
    
    private func setupPages() {
        pages = [emojiPage, howTodayPage, goodPointPage, improvementPage]
        
        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true)
        }
    }
    
    private func configurePages() {
        emojiPage.selectedEmojiLabel.text = diary.emoji
        howTodayPage.textView.text = diary.howToday
        goodPointPage.textView.text = diary.good
        improvementPage.textView.text = diary.improve
        
        // 읽기 전용으로 설정
        emojiPage.emojiCollectionView.isUserInteractionEnabled = false
        howTodayPage.textView.isEditable = false
        goodPointPage.textView.isEditable = false
        improvementPage.textView.isEditable = false
        improvementPage.saveButton.isHidden = true
    }
    
    private func updateNavigationBar() {
        if isEditMode {
            navigationItem.leftBarButtonItem = deleteButton
            navigationItem.rightBarButtonItem = saveButton
        } else {
            navigationItem.leftBarButtonItem = closeButton
            navigationItem.rightBarButtonItem = editButton
        }
    }
    
    private func updatePagesEditMode() {
        emojiPage.emojiCollectionView.isUserInteractionEnabled = isEditMode
        howTodayPage.textView.isEditable = isEditMode
        goodPointPage.textView.isEditable = isEditMode
        improvementPage.textView.isEditable = isEditMode
        improvementPage.saveButton.isHidden = true
    }
    
    private func deleteDiary() {
        CoreDataManager.shared.deleteDiary(diary: diary)
        dismiss(animated: true)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func editButtonTapped() {
        isEditMode = true
    }
    
    @objc private func deleteButtonTapped() {
        let alert = UIAlertController(title: "일기 삭제", message: "일기를 삭제하시겠습니까?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.deleteDiary()
        })
        
        present(alert, animated: true)
    }
    
    @objc private func saveButtonTapped() {
        CoreDataManager.shared.updateDiary(diary: diary, emoji: emojiPage.inputText, howToday: howTodayPage.inputText, good: goodPointPage.inputText, improve: improvementPage.inputText)
        isEditMode = false
    }
}

extension RUDDiary: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let viewController = viewControllers?.first,
              let index = pages.firstIndex(of: viewController) else {
            return 0
        }
        return index
    }
}

extension RUDDiary: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed,
           let visibleViewController = pageViewController.viewControllers?.first,
           let index = pages.firstIndex(of: visibleViewController) {
            currentIndex = index
        }
    }
}
