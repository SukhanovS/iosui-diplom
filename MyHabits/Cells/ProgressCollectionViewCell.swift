//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Stas Sukhanov on 4.01.2023.
//

import Foundation
import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    //Заголовок "Все получится!"
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    Лейбл с процентами выполнения привычек
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "\(Int(HabitsStore.shared.todayProgress*100))%"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    прогресс бар
    private lazy var progressBar: UIProgressView = {
        let progress = UIProgressView()
        progress.progress = HabitsStore.shared.todayProgress
        progress.tintColor = Colors.purpleColor
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        contentView.addSubview(label)
        contentView.addSubview(percentLabel)
        contentView.addSubview(progressBar)
        setupConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            
            percentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            percentLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            
            progressBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 38),
            progressBar.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            progressBar.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            progressBar.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 45),
            
    ])
    }
    
    /// Функция настройки ячейки, вызывается в HabitsViewController при настройке Сollection View.
    func setup(){
        percentLabel.text = "\(Int(HabitsStore.shared.todayProgress*100))%"
        progressBar.progress = HabitsStore.shared.todayProgress
    }
}
