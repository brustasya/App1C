//
//  TitleView.swift
//  App1C
//
//  Created by Станислава on 08.04.2024.
//

import UIKit

final class TitleView: UILabel {
    private let title: String
    
    init(frame: CGRect, title: String) {
        self.title = title
        super.init(frame: frame)

        setupTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitle() {
        text = title
        textColor = .black
        font = .systemFont(ofSize: 22, weight: .semibold)
        textAlignment = .left
        numberOfLines = 2
    }
}
