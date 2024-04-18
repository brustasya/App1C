//
//  WeekDaySelectorView.swift
//  App1C
//
//  Created by Станислава on 08.04.2024.
//

import UIKit

class WeekDaySelectorView: UIView {
    
    var dayButtons: [UIButton] = []
    var selectedDayIndex: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    private func setupButtons() {
        let daysOfWeek = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб"]
        
        for (index, day) in daysOfWeek.enumerated() {
            let button = UIButton()
            button.setTitle(day, for: .normal)
            button.tag = index
           
            button.addTarget(self, action: #selector(dayButtonTapped(_:)), for: .touchUpInside)
            addSubview(button)
            dayButtons.append(button)
        }
        
        layoutButtons()
        dayButtons[0].sendActions(for: .touchUpInside)
    }
        
    private func layoutButtons() {
        let buttonWidth = frame.width / CGFloat(dayButtons.count)
        let buttonHeight = frame.height
        
        for (index, button) in dayButtons.enumerated() {
            let xPosition = CGFloat(index) * buttonWidth
            button.frame = CGRect(x: xPosition, y: 0, width: buttonWidth, height: buttonHeight)
            button.backgroundColor = .clear
            button.setTitleColor(.darkGray, for: .normal)
            button.layer.cornerRadius = buttonHeight / 2
        }
    }
    
    @objc private func dayButtonTapped(_ sender: UIButton) {
        selectedDayIndex = sender.tag
        updateButtonAppearance()
    }
    
    private func updateButtonAppearance() {
        for (index, button) in dayButtons.enumerated() {
            if let selectedDayIndex = selectedDayIndex, index == selectedDayIndex {
                button.backgroundColor = Colors.yellow.uiColor // Цвет выделенного дня
                button.setTitleColor(.black, for: .normal)
            } else {
                button.backgroundColor = .clear
                button.setTitleColor(.darkGray, for: .normal)
            }
        }
    }
}
