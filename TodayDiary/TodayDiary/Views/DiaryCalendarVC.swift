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
        
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
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
    
    private func getStringToDate(strDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "Ko_KR") as? TimeZone
        
        return dateFormatter.date(from: strDate)!
    }
    
    @objc private func settingButtonTapped() {
        print("설정 버튼 탭")
    }
    
    @objc private func didTapPlusButton() {
        let pageVC = DiaryPageVC(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        let navController = UINavigationController(rootViewController: pageVC)
        navController.modalPresentationStyle = .fullScreen
        
        present(navController, animated: true)
    }
}

extension DiaryCalendarVC: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        if let _ = dateComponents {
            let diaryVC = DiaryWrittenVC()
            diaryVC.modalPresentationStyle = .fullScreen
            present(diaryVC, animated: true)
        }
    }
}

//#Preview {
//    DiaryCalendarVC()
//}
