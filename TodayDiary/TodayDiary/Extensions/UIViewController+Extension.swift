//
//  UIViewController+Extension.swift
//  TodayDiary
//
//  Created by 서정원 on 5/11/25.
//

import UIKit

extension UIViewController {
    func setupTitleAndTextViewLayout(
        titleLabel: UILabel,
        textView: UITextView,
        topMargin: CGFloat = 20,
        labelSideMargin: CGFloat = 20,
        textViewSideMargin: CGFloat = 20,
        textViewHeight: CGFloat = 360
    ) {
        guard let view = self.view else { return }
        
        view.addSubview(titleLabel)
        view.addSubview(textView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topMargin),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: labelSideMargin),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -labelSideMargin),
            
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topMargin),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: textViewSideMargin),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -textViewSideMargin),
            textView.heightAnchor.constraint(equalToConstant: textViewHeight),
        ])
    }
}
