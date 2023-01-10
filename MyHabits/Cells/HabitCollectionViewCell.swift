//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Stas Sukhanov on 4.01.2023.
//

import Foundation
import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    //    название привычки
    private lazy var habitLabel : UILabel = {
        let label = UILabel()
        label.text = "Привычка"
        label.textColor = Colors.greenColor
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //    лейбл со временем
    private lazy var timeLabel : UILabel = {
        let time = UILabel()
        time.text = "Каждый день в 10:00"
        time.textColor = .systemGray
        time.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        time.numberOfLines = 0
        time.translatesAutoresizingMaskIntoConstraints = false
        return time
    }()
    
    //    лейбл с кол-вом привычек
    private lazy var countLabel : UILabel = {
        let count = UILabel()
        count.text = "Счетчик: 2"
        count.textColor = .systemGray
        count.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        count.numberOfLines = 0
        count.translatesAutoresizingMaskIntoConstraints = false
        return count
    }()
    
    //    Кнопка выполнения привычки.
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        return button
    }()
    
    //    Галочка
    private lazy var checkImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "checkmark")
        img.tintColor = .white
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isHidden = true
        return img
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.backgroundColor = .white
        
        contentView.addSubview(habitLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(checkButton)
        contentView.addSubview(checkImage)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //    создание констрейнтов
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            habitLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            habitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            habitLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,  constant: -68),
            
            timeLabel.topAnchor.constraint(equalTo: habitLabel.bottomAnchor, constant: 8),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkButton.heightAnchor.constraint(equalToConstant: 36),
            checkButton.widthAnchor.constraint(equalToConstant: 36),
            
            checkImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            checkImage.heightAnchor.constraint(equalToConstant: 25),
            checkImage.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    //    Функция настройки ячейки. Вызывается в HabitsViewController при настройке Сollection View.
    func setupCell(index: Int) {
        
        habitLabel.tag = index
        habitLabel.textColor = HabitsStore.shared.habits[index].color
        habitLabel.text = HabitsStore.shared.habits[index].name
        checkButton.layer.borderColor = HabitsStore.shared.habits[index].color.cgColor
        countLabel.text = "Счетчик: \(HabitsStore.shared.habits[index].trackDates.count)"
        timeLabel.text = HabitsStore.shared.habits[index].dateString
        
        if HabitsStore.shared.habits[index].isAlreadyTakenToday {
            checkButton.backgroundColor = UIColor(cgColor: HabitsStore.shared.habits[index].color.cgColor)
            checkImage.isHidden = false
        } else {
            checkButton.backgroundColor = nil
            checkImage.isHidden = true
        }
    }
    
    //    Функция проявления галочки, при нажатии на кнопку и отправка уведомления.
    @objc func clickButton () {
        
        let index = habitLabel.tag
        if  HabitsStore.shared.habits[index].isAlreadyTakenToday {
        } else {
            checkButton.backgroundColor = UIColor(cgColor: checkButton.layer.borderColor!)
            HabitsStore.shared.track(HabitsStore.shared.habits[index])
            countLabel.text = "Счетчик: \(HabitsStore.shared.habits[index].trackDates.count)"
            checkImage.isHidden = false
        }
        NotificationCenter.default.post(name: Notification.Name("reloadProgressCell"), object: nil)  // Отправляем уведомление, о необходимости обновления view.
    }
}
