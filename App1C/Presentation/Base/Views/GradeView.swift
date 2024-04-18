//
//  GradeView.swift
//  App1C
//
//  Created by Станислава on 05.04.2024.
//

import UIKit

class GradeView: UIView {
    private lazy var gradeLabel = UILabel()
    private lazy var contentView = UIView()
    
    init(model: GradeModel, contentView: UIView, frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView = contentView
        gradeLabel.text = model.text
        gradeLabel.textColor = model.textColor
        backgroundColor = model.color
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(self)
        addSubview(gradeLabel)
        translatesAutoresizingMaskIntoConstraints = false
        gradeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 15
        gradeLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        NSLayoutConstraint.activate([
            gradeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            gradeLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
