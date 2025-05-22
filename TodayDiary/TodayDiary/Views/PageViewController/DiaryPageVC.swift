//
//  DiaryPageViewController.swift
//  TodayDiary
//
//  Created by 서정원 on 4/30/25.
//

import UIKit

class DiaryPageVC: UIPageViewController {
    private var pages: [UIViewController] = []
    private var currentIndex: Int = 0
    
    private let emojiPage = DiaryEmojiVC()
    private let howTodayPage = DiaryHowTodayVC()
    private let goodPointPage = DiaryGoodVC()
    private let improvementPage = DiaryImprovementVC()
    
    //MARK: - Property
    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        button.tintColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        improvementPage.delegate = self
        dataSource = self
        
        setupNavigation()
        setupPages()
    }
    
    private func setupNavigation() {
        view.backgroundColor = .mainBackgroundColor
        navigationItem.leftBarButtonItem = cancelButton
        title = DateFormatter.todayString()
    }
    
    private func setupPages() {
        pages = [emojiPage, howTodayPage, goodPointPage, improvementPage]
        
        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true)
        }
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    
}

extension DiaryPageVC: UIPageViewControllerDataSource {
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

extension DiaryPageVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed,
           let visibleViewController = pageViewController.viewControllers?.first,
           let index = pages.firstIndex(of: visibleViewController) {
            currentIndex = index
        }
    }
}

extension DiaryPageVC: DiarySaveDelegate {
    func saveDiary() {
        CoreDataManager.shared.saveDiary(currentDay: Date().strippedTime, emoji: emojiPage.inputText, howToday: howTodayPage.inputText, good: goodPointPage.inputText, improve: improvementPage.inputText)
    }
}
