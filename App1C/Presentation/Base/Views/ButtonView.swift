//
//  ButtonView.swift
//  App1C
//
//  Created by Станислава on 03.04.2024.
//

import UIKit

final class ButtonView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        backgroundColor = Colors.yellow.uiColor
        setTitleColor(.black, for: .normal)
        layer.cornerRadius = 15        
    }
}
