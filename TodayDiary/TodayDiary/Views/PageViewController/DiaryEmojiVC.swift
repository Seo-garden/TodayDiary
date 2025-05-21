//
//  EmojiVC.swift
//  TodayDiary
//
//  Created by 서정원 on 4/30/25.
//

import UIKit

class DiaryEmojiVC: UIViewController {
    private let emojis = ["😊", "😢", "😍", "😎", "😡", "🥳", "😴", "🤔", "😱"]
    private var selectedEmojiIndex: Int?
    private let identifier = "EmojiCell"
    
    var inputText: String {
        selectedEmojiLabel.text ?? ""
    }
    //MARK: - Property
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "오늘 하루를 이모지로 표현해보세요 "
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var emojiCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.itemSize = CGSize(width: 40, height: 40)
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: identifier)
        
        return collectionView
    }()
    
    let selectedEmojiView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.isHidden = false
        
        return view
    }()
    
    let selectedEmojiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        emojiCollectionView.dataSource = self
        emojiCollectionView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setupUI() {
        view.backgroundColor = .mainBackgroundColor
        
        view.addSubview(titleLabel)
        view.addSubview(emojiCollectionView)
        view.addSubview(selectedEmojiView)
        selectedEmojiView.addSubview(selectedEmojiLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emojiCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            emojiCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            emojiCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            emojiCollectionView.heightAnchor.constraint(equalToConstant: 120),
            
            selectedEmojiView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            selectedEmojiView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            selectedEmojiView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -60),
            
            selectedEmojiLabel.centerXAnchor.constraint(equalTo: selectedEmojiView.centerXAnchor),
            selectedEmojiLabel.centerYAnchor.constraint(equalTo: selectedEmojiView.centerYAnchor)
        ])
    }
    
    private func updateSelectedEmoji(at index: Int) {
        selectedEmojiIndex = index
        let emoji = emojis[index]
        selectedEmojiLabel.text = emoji
        selectedEmojiView.isHidden = false
        
        UIView.animate(withDuration: 0.2, animations: {
            self.selectedEmojiView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.selectedEmojiView.transform = .identity
            }
        }
    }
}

extension DiaryEmojiVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateSelectedEmoji(at: indexPath.item)
    }
}

extension DiaryEmojiVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
                as? EmojiCell else { return UICollectionViewCell() }
        let emoji = emojis[indexPath.item]
        cell.configure(with: emoji)
        
        return cell
    }
}
