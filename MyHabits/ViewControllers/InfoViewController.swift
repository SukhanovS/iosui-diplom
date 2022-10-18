//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Stas Sukhanov on 16.10.2022.
//

import Foundation
import UIKit

class InfoViewController: UIViewController{
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarCustomization()
    }
    
    // MARK: Customization and Grouping Functions
    
    func navBarCustomization () {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.title = "Информация"
    }

    lazy private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy private var text: UITextField = {
        let text = UITextField()
        text.placeholder = "Привычка за 21 день"
        text.font = UIFont(name: "headLine", size: 20.0)
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: text.frame.height))
        text.leftViewMode = .always
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy private var info: UITextField = {
       let textInfo = UITextField()
        
        textInfo.translatesAutoresizingMaskIntoConstraints = false
        return textInfo
    }()
    
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            text.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 16),
            text.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 120),
            stackView.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        addConstraints()
    }
        
    func addViews() {
        view.addSubview(scrollView)
        
        stackView.addArrangedSubview(text)
        
        scrollView.addSubview(stackView)
    }
}
