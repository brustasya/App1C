//
//  SelectorView.swift
//  App1C
//
//  Created by Станислава on 08.04.2024.
//

import UIKit

protocol SelectorDelegate: AnyObject {
    func select(at index: Int)
}

class SelectorView: UIView {
    
    weak var delegate: SelectorDelegate?
    
    var dayButtons: [UIButton] = []
    var selectedDayIndex: Int?
    var buttonsTitles: [String] = []
    var width: CGFloat = 50
    var color: UIColor = Colors.yellow.uiColor
    var borderColor: UIColor = .clear
    
    init(frame: CGRect, buttonsTitles: [String], delegate: SelectorDelegate?, width: CGFloat = 50, color: UIColor = Colors.yellow.uiColor, borderColor: UIColor = .clear) {
        self.buttonsTitles = buttonsTitles
        self.delegate = delegate
        self.width = width
        self.color = color
        self.borderColor = borderColor
        super.init(frame: frame)

        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //setupButtons()
    }
    
    private func setupButtons() {        
        for (index, day) in buttonsTitles.enumerated() {
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
        let buttonWidth: CGFloat = width
        let buttonHeight = frame.height
        
        for (index, button) in dayButtons.enumerated() {
            let xPosition = CGFloat(index) * (frame.width / CGFloat(dayButtons.count))
            button.frame = CGRect(x: xPosition, y: 0, width: buttonWidth, height: buttonHeight)
            button.backgroundColor = .clear
            button.layer.borderColor = borderColor.cgColor
            button.layer.borderWidth = 1
            button.setTitleColor(.darkGray, for: .normal)
            button.layer.cornerRadius = buttonHeight / 2
        }
    }
    
    @objc private func dayButtonTapped(_ sender: UIButton) {
        selectedDayIndex = sender.tag
        delegate?.select(at: selectedDayIndex ?? 0)
        updateButtonAppearance()
    }
    
    private func updateButtonAppearance() {
        for (index, button) in dayButtons.enumerated() {
            if let selectedDayIndex = selectedDayIndex, index == selectedDayIndex {
                button.backgroundColor = color
                button.setTitleColor(.black, for: .normal)
            } else {
                button.backgroundColor = .clear
                button.setTitleColor(.darkGray, for: .normal)
            }
        }
    }
}
