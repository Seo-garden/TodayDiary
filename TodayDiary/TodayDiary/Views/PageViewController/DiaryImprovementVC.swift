//
//  DiaryImprovementVC.swift
//  TodayDiary
//
//  Created by 서정원 on 4/30/25.
//

import UIKit

protocol DiarySaveDelegate: AnyObject {
    func saveDiary()
}

class DiaryImprovementVC: UIViewController {
    var inputText: String {
        textView.text
    }
    
    weak var delegate: DiarySaveDelegate?
    
    //MARK: - Property
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "오늘 하루를 좀 더 나은 내일을 위해 개선할 수 있는 것을 적어보세요 !"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    let textView = UITextView.makeDiaryTextView()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTitleAndTextViewLayout(titleLabel: titleLabel, textView: textView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setupUI() {
        view.backgroundColor = .mainBackgroundColor
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 56),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func saveButtonTapped() {
        delegate?.saveDiary()
        dismiss(animated: true)
    }

}


