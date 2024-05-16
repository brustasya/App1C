//
//  CourseView.swift
//  App1C
//
//  Created by Станислава on 10.04.2024.
//

import UIKit

final class CourseView: UIView {
    private lazy var checkButton = UIButton()
    private lazy var statusLabel = UILabel()
    private lazy var titleLabel = UILabel()
    private lazy var openButton = UIButton()
    private lazy var infoButton = UIButton()
    
    public lazy var courseID = 0
    public lazy var id = 0
    public lazy var y: CGFloat = 0
    public lazy var countOfDependencies = 0
    public lazy var isDep = false
    
    private lazy var isSelected = false
    private lazy var isDepsOpen = false
    private lazy var isOffline = false
    private lazy var closed: Bool = false
    
    var isOpen = true {
        didSet {
            if !isOpen {
                isDepsOpen = false
                openButton.setImage(Images.down.uiImage, for: .normal)
            }
        }
    }
    
    weak var delegate: CourseSelecitonDelegate?
    
    public var countOfSelectedDeps = 0 {
        didSet {
            guard !closed else { return }
            if countOfDependencies == countOfSelectedDeps {
                backgroundColor = .white
                checkButton.isUserInteractionEnabled = true
            } else {
                backgroundColor = .systemGray6
                checkButton.isUserInteractionEnabled = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        
        checkButton.frame = CGRect(x: 8, y: bounds.midY - 15, width: 30, height: 30)
        statusLabel.frame = CGRect(x: bounds.maxX - 110, y: bounds.maxY - 28, width: 100, height: 20)
        titleLabel.frame = CGRect(x: checkButton.frame.maxX + 8, y: bounds.midY - 20, width: bounds.width - 120, height: 40)
        openButton.frame = CGRect(x: bounds.maxX - 30, y: 8, width: 20, height: 20)
        infoButton.frame = CGRect(x: openButton.frame.minX - 30, y: 6, width: 25, height: 25)
        
        addSubview(checkButton)
        addSubview(titleLabel)
        addSubview(statusLabel)
        addSubview(openButton)
        addSubview(infoButton)
        
        openButton.tintColor = .gray
        openButton.setImage(Images.down.uiImage, for: .normal)
        
        infoButton.tintColor = .black
        infoButton.setImage(Images.info.uiImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 25, weight: .light)), for: .normal)
        
        checkButton.tintColor = .gray
        checkButton.setImage(Images.check.uiImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 23, weight: .medium)), for: .normal)
        
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        statusLabel.textColor = .darkGray
        statusLabel.textAlignment = .right
        statusLabel.isHidden = true
        
        checkButton.addTarget(self, action: #selector(selectCourse), for: .touchUpInside)
        openButton.addTarget(self, action: #selector(openButtonTapped), for: .touchUpInside)        
    }
    
    @objc private func selectCourse() {
        if isSelected {
            checkButton.tintColor = .gray
            checkButton.setImage(Images.check.uiImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 23, weight: .medium)), for: .normal)
            delegate?.unselectCourse(id: courseID)
        } else {
            checkButton.tintColor = Colors.darkgreen.uiColor
            checkButton.setImage(Images.fillCheck.uiImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 23, weight: .medium)), for: .normal)
            delegate?.selectCourse(id: courseID)
        }
    }
    
    @objc func openButtonTapped() {
        if isDepsOpen {
            openButton.setImage(Images.down.uiImage, for: .normal)
            delegate?.closeDependencies(view: self)
        } else {
            openButton.setImage(Images.up.uiImage, for: .normal)
            delegate?.openDependencies(view: self)
        }
        isDepsOpen = !isDepsOpen
    }
    
    func configure(with model: CourseSelectionModel) {
        courseID = model.id
        titleLabel.text = model.title

        closed = model.closed
        countOfDependencies = model.courseChildren.count
        
        if countOfDependencies == countOfSelectedDeps {
            backgroundColor = .white
            checkButton.isUserInteractionEnabled = true
        } else {
            backgroundColor = .systemGray6
            checkButton.isUserInteractionEnabled = false
        }
        
        if model.closed {
            backgroundColor = Colors.salat.uiColor
            checkButton.isUserInteractionEnabled = true
        }
        
        if model.wasInLoad {
            titleLabel.frame.origin.x -= 30
            titleLabel.frame.size.width += 30
            
            checkButton.isHidden = true
        }
        
        if countOfDependencies == 0 {
            openButton.isHidden = true
        }
        
        if isDep {
            titleLabel.frame.origin.x -= 30
            titleLabel.frame.size.width += 30
            
            checkButton.isHidden = true
            backgroundColor = .systemGray6
        }
    }
    
    func setupCountOfDeps() {
        countOfSelectedDeps = countOfDependencies
    }
    
    func select(isOffline: Bool) {
        self.isOffline = isOffline
        statusLabel.text = isOffline ? "Очно" : "Экстерн"
        statusLabel.isHidden = closed
        checkButton.tintColor = Colors.darkgreen.uiColor
        checkButton.setImage(Images.fillCheck.uiImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 23, weight: .medium)), for: .normal)
        isSelected = true
    }
    
    func finalSelect(takenAsLoad: Bool) {
        statusLabel.text = takenAsLoad ? "В нагрузку" : "Не в нагрузку"
        statusLabel.isHidden = false
        checkButton.tintColor = Colors.darkgreen.uiColor
        checkButton.setImage(Images.fillCheck.uiImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 23, weight: .medium)), for: .normal)
        isSelected = true
    }
    
    func unSelect() {
        statusLabel.isHidden = true
        checkButton.tintColor = .gray
        checkButton.setImage(Images.check.uiImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 23, weight: .medium)), for: .normal)
        isSelected = false
    }
}
