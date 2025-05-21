//
//  DiaryCalendarVC.swift
//  TodayDiary
//
//  Created by 서정원 on 4/28/25.
//

import UIKit

class DiaryCalendarVC: UIViewController {
    //MARK: - Property
    private lazy var settingButton: UIBarButtonItem = {
        let settingImage = UIImage(systemName: "gearshape")
        let button = UIBarButtonItem(image: settingImage, style: .plain, target: self, action: #selector(settingButtonTapped))
        button.tintColor = .black
        return button
    }()
    
    private lazy var calendarView: UICalendarView = {
        let view = UICalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.wantsDateDecorations = true        //달력을 Custom 하기 위한 속성
        view.locale = .current
        view.calendar = .current
        view.fontDesign = .rounded
        view.tintColor = .white
        
        return view
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
        
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
        
        setupNavigation()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updatePlusButtonState()
    }
    
    private func setupNavigation() {
        navigationItem.title = "캘린더"
        navigationItem.rightBarButtonItem = settingButton
        
        if let navigationBar = navigationController?.navigationBar {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground() // 불투명하게 설정
            appearance.backgroundColor = .mainBackgroundColor
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    private func setupUI() {
        view.addSubview(calendarView)
        view.addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            plusButton.widthAnchor.constraint(equalToConstant: 56),
            plusButton.heightAnchor.constraint(equalToConstant: 56),
            plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    open func getStringToDate(strDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "Ko_KR") as? TimeZone
        
        return dateFormatter.date(from: strDate)!
    }
    
    private func updatePlusButtonState() {
        let hasTodayDiary = CoreDataManager.shared.hasDiaryDate(date: Date())
        plusButton.isEnabled = !hasTodayDiary
        plusButton.alpha = hasTodayDiary ? 0.5 : 1.0 // 비활성화 상태를 시각적으로 표시
    }
    
    @objc private func settingButtonTapped() {
        print("설정 버튼 탭")
    }
    
    @objc private func plusButtonTapped() {
        let pageVC = DiaryPageVC(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        let navController = UINavigationController(rootViewController: pageVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}

extension DiaryCalendarVC: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        if let dateComponents = dateComponents, let date = Calendar.current.date(from: dateComponents) {        //해당 날짜로 작성된 일기가 있다면
            if CoreDataManager.shared.hasDiaryDate(date: date) {
                if let diary = CoreDataManager.shared.fetchDiary(for: date) {
                    let readDiaryVC = ReadDiaryVC(diary: diary)
                    let navController = UINavigationController(rootViewController: readDiaryVC)
                    navController.modalPresentationStyle = .fullScreen
                    present(navController, animated: true)
                }
            }
        }
    }
}
