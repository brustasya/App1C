//
//  ViewController.swift
//  App1C
//
//  Created by Станислава on 28.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select Date and Time"
        textField.textAlignment = .center
        return textField
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.tintColor = Colors.red.uiColor
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.setDate(Date(timeIntervalSinceNow: 2000000), animated: false)
        return datePicker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Add date picker as input view for text field
        dateTextField.inputView = datePicker
        
//        // Create toolbar with done button for date picker
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
//        toolbar.setItems([doneButton], animated: true)
//        dateTextField.inputAccessoryView = toolbar
//
        // Add text field to view
        view.addSubview(dateTextField)
        view.addSubview(datePicker)
        datePicker.center = view.center
//        dateTextField.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            dateTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            dateTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            dateTextField.widthAnchor.constraint(equalToConstant: 200),
//            dateTextField.heightAnchor.constraint(equalToConstant: 40)
//        ])
        
        // Add target for date picker value changed
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        for subView in datePicker.subviews {
            for view in subView.subviews {
                view.backgroundColor = Colors.paleYellow.uiColor
                view.layer.cornerRadius = 15
                for sub in view.subviews {
                    sub.backgroundColor = Colors.paleYellow.uiColor
                    sub.layer.cornerRadius = 15
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = true
    }
    
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        dateTextField.text = formatter.string(from: sender.date)
        for subView in datePicker.subviews {
            for view in subView.subviews {
                view.backgroundColor = Colors.paleYellow.uiColor
                view.layer.cornerRadius = 15
                for sub in view.subviews {
                    sub.backgroundColor = Colors.paleYellow.uiColor
                    view.layer.cornerRadius = 15
                }
            }
        }
    }
    
    @objc func doneButtonPressed() {
        dateTextField.resignFirstResponder()
    }
}
