//
//  ViewController.swift
//  MyHabits
//
//  Created by Stas Sukhanov on 16.10.2022.
//

import UIKit

class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    // настройка навбара
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarCustomization()
    }
    
    
    func navBarCustomization () {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = Colors.purpleColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.title = "Создать"
        //кнопка "отменить"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissSelf))
        //        кнопка "сохранить"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveHabbit))
        
    }
    
    //Заголовок
    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.text = "Название"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Поле ввода названия привычки
    private lazy var nameHabit: UITextField = {
        let nameHabit = UITextField()
        nameHabit.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        nameHabit.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        nameHabit.textColor = Colors.blueColor
        nameHabit.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        nameHabit.translatesAutoresizingMaskIntoConstraints = false
        return nameHabit
    }()
    
    // заголовок "цвет"
    private lazy var nameColor: UILabel = {
        let color = UILabel()
        color.text = "Цвет"
        color.numberOfLines = 0
        color.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        color.translatesAutoresizingMaskIntoConstraints = false
        return color
    }()
    
    private lazy var colorPicker: UIButton = {
        let picker = UIButton()
        picker.layer.cornerRadius = 15
        picker.backgroundColor = Colors.redColor
        picker.addTarget(self, action: #selector(didTapColorPicker), for: .touchUpInside)
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private lazy var nameDate: UILabel = {
        let nameDate = UILabel()
        nameDate.translatesAutoresizingMaskIntoConstraints = false
        nameDate.text = "Время"
        nameDate.numberOfLines = 0
        nameDate.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return nameDate
    }()
    
    private lazy var secondNameDate: UILabel = {
        let nameDate = UILabel()
        nameDate.translatesAutoresizingMaskIntoConstraints = false
        nameDate.text = "Каждый день в "
        nameDate.numberOfLines = 0
        nameDate.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return nameDate
    }()
    
    private lazy var timePickerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "11:00 PM"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = Colors.purpleColor
        return label
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(didSelect), for: .valueChanged)
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    /// Кнопка удаления привычки внизу экрана.
    private lazy var deleteHabbitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(deleteHabbit), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(labelName)
        view.addSubview(nameHabit)
        view.addSubview(nameColor)
        view.addSubview(colorPicker)
        view.addSubview(nameDate)
        view.addSubview(secondNameDate)
        view.addSubview(timePickerLabel)
        view.addSubview(timePicker)
        view.addSubview(deleteHabbitButton)
        addConstraints()
        setupIfCalledForEditing()
    }
    
    
    // Контейнеры для хранения названия, времени и цвета привычки.
    private var name: String = ""
    private var date: Date = Date()
    private var color: UIColor = .systemRed
    
    //добавил констрейнты
    func addConstraints () {
        NSLayoutConstraint.activate([
            ///Заголовок
            labelName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            /// Поле ввода Названия привычки
            nameHabit.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 16),
            nameHabit.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameHabit.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nameHabit.heightAnchor.constraint(equalToConstant: 20),
            
            // заголовок "цвет"
            nameColor.topAnchor.constraint(equalTo: nameHabit.bottomAnchor, constant: 16),
            nameColor.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            // Выбор цвета
            colorPicker.topAnchor.constraint(equalTo: nameColor.bottomAnchor, constant: 16),
            colorPicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            //заголовок Время
            nameDate.topAnchor.constraint(equalTo: colorPicker.bottomAnchor, constant: 16),
            nameDate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            //неизменяемая часть лейбла времени
            secondNameDate.topAnchor.constraint(equalTo: nameDate.bottomAnchor, constant: 16),
            secondNameDate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            //изменяемая часть лейбла времени
            timePickerLabel.topAnchor.constraint(equalTo: nameDate.bottomAnchor, constant: 16),
            timePickerLabel.leftAnchor.constraint(equalTo: secondNameDate.rightAnchor),
            
            // пикер
            timePicker.topAnchor.constraint(equalTo: secondNameDate.bottomAnchor, constant: 16),
            timePicker.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            // Кнопка удаления привычки внизу экрана.
            deleteHabbitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            deleteHabbitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            deleteHabbitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            deleteHabbitButton.heightAnchor.constraint(equalToConstant: 30)
            
            
            
        ])
    }
    
    // cохранение текста из ТекстФилда в контейнер.
    @objc func statusTextChanged(_ textField: UITextField){
        if let i = textField.text {
            self.name = i
        }
    }
    
    //    функция выбора цвета
    @objc private func didTapColorPicker() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.selectedColor = self.colorPicker.backgroundColor!
        present(colorPicker, animated: true)
    }
    
    //функция сохранения выбранного цвета
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        colorPicker.backgroundColor = color
        self.color = color
    }
    
    //функция добавления значения времени из пикера в изменяемую часть заголовка
    @objc private func didSelect() {
        let date = DateFormatter()
        date.dateFormat = "hh:mm a"
        timePickerLabel.text = "\(date.string(from: timePicker.date))"
        self.date = timePicker.date
    }
    
//    функция удаления привычки
    @objc func deleteHabbit () {
        alertController.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { _ in
        }))
        alertController.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { _ in
            HabitsStore.shared.habits.remove(at: self.habitIndex)
            NotificationCenter.default.post(name: Notification.Name("deleteCell"), object: self.habitIndex)
            NotificationCenter.default.post(name: Notification.Name("hideDetailView"), object: nil)
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    var calledForEditing = false // Произошел ли переход экран для настройки или для создания привычки.
    var habitIndex: Int = 0 // Переменная, в которую передается индекс привычки, согласно которому настраивается экран.
    //функция закрытия окна создания привычки
    
    let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку?", preferredStyle: .alert)
    
    
    @objc private func dismissSelf(){
        calledForEditing = false
        dismiss(animated: true, completion: nil)
    }
    
    //    функция сохранения привычки
    @objc private func saveHabbit() {
        if calledForEditing {
            HabitsStore.shared.habits[habitIndex].name = self.name
            HabitsStore.shared.habits[habitIndex].date = self.date
            HabitsStore.shared.habits[habitIndex].color = self.color
            print("\(self.name) 2")
        }else{
            let newHabit = Habit(name: self.name, date: self.date, color: self.color)
            
            let store = HabitsStore.shared
            store.habits.append(newHabit)
        }
        
        calledForEditing = false
        HabitsStore.shared.save()
        
        NotificationCenter.default.post(name: Notification.Name("addCell"), object: nil) // Отправка уведомления о необходимоти обновления CollectionView.
        NotificationCenter.default.post(name: Notification.Name("hideDetailView"), object: nil)// Отправка уведомления, о необходимости пропустить HabitDetailsViewController.
        dismiss(animated: true, completion: nil)
        
    }
    
    /// Функция настройки View, в случае если переход на контроллер произошел для настройки имеющейся привычки, а не создания новой.
    private func setupIfCalledForEditing () {
      
        if calledForEditing {
            labelName.textColor = HabitsStore.shared.habits[habitIndex].color
            labelName.text = HabitsStore.shared.habits[habitIndex].name
            colorPicker.backgroundColor = HabitsStore.shared.habits[habitIndex].color
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            timePickerLabel.text = "\(dateFormatter.string(from: HabitsStore.shared.habits[habitIndex].date))"
            
            self.name = HabitsStore.shared.habits[habitIndex].name
            self.date = HabitsStore.shared.habits[habitIndex].date
            self.color = HabitsStore.shared.habits[habitIndex].color
            
            self.deleteHabbitButton.isHidden = false
        }
    }
    
}

