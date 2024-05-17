//
//  ChoosenCourseView.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import UIKit

final class ChoosenCourseView: UIView {
    private lazy var checkButton = UIButton()
    private lazy var statusLabel = UILabel()
    private lazy var loadLabel = UILabel()
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
    
    private var numberOfLines = 0
    
    var isOpen = true {
        didSet {
            if !isOpen {
                isDepsOpen = false
                openButton.setImage(Images.down.uiImage, for: .normal)
            }
        }
    }
    
    weak var delegate: ChoosenCourseSelectionDelegate?
    
    public var countOfSelectedDeps = 0
    
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
        layer.borderWidth = 2
        
        checkButton.frame = CGRect(x: 8, y: bounds.midY - 15, width: 30, height: 30)
        statusLabel.frame = CGRect(x: bounds.maxX - 70, y: bounds.maxY - 26, width: 60, height: 20)
        loadLabel.frame = CGRect(x: statusLabel.frame.minX - 110, y: bounds.maxY - 26, width: 100, height: 20)
        titleLabel.frame = CGRect(x: checkButton.frame.maxX + 8, y: bounds.midY - 20, width: bounds.width - 120, height: 40)
        openButton.frame = CGRect(x: bounds.maxX - 30, y: 8, width: 20, height: 20)
        infoButton.frame = CGRect(x: openButton.frame.minX - 30, y: 6, width: 25, height: 25)
        
        addSubview(checkButton)
        addSubview(titleLabel)
        addSubview(statusLabel)
        addSubview(loadLabel)
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
        
        loadLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        loadLabel.textColor = .darkGray
        loadLabel.textAlignment = .right
        loadLabel.isHidden = true
        
        checkButton.addTarget(self, action: #selector(selectCourse), for: .touchUpInside)
        openButton.addTarget(self, action: #selector(openButtonTapped), for: .touchUpInside)
        infoButton.addTarget(self, action: #selector(getInfo), for: .touchUpInside)
    }
    
    @objc private func selectCourse() {
        if isSelected {
            checkButton.tintColor = .gray
            checkButton.setImage(Images.check.uiImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 23, weight: .medium)), for: .normal)
            delegate?.unselectChoosenCourse(id: courseID)
        } else {
            checkButton.tintColor = Colors.darkgreen.uiColor
            checkButton.setImage(Images.fillCheck.uiImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 23, weight: .medium)), for: .normal)
            delegate?.selectChoosenCourse(id: courseID)
        }
    }
    
    @objc func openButtonTapped() {
        if isDepsOpen {
            openButton.setImage(Images.down.uiImage, for: .normal)
            delegate?.closeChoosenDependencies(view: self)
        } else {
            openButton.setImage(Images.up.uiImage, for: .normal)
            delegate?.openChoosenDependencies(view: self)
        }
        isDepsOpen = !isDepsOpen
    }
    
    @objc private func getInfo() {
        delegate?.getInfo(id: courseID)
    }
    
    func configure(with model: ChoosenCourseSelectionModel) {
        courseID = model.id
        titleLabel.text = model.title
        closed = model.closed
        countOfDependencies = model.courseChildren.count
        
        if countOfDependencies == 0 {
            openButton.isHidden = true
        }
        
        backgroundColor = .white
        
        layer.borderColor = model.isStarted
                ? Colors.darkgreen.uiColor.cgColor
                : Colors.red.uiColor.cgColor
       
        if model.closed {
            if !isDep {
                titleLabel.frame.origin.x -= 20
                titleLabel.frame.size.width += 20
            }
            
            checkButton.isHidden = true
            backgroundColor = Colors.salat.uiColor
        }
        
        if isDep {
            titleLabel.frame.origin.x -= 20
            titleLabel.frame.size.width += 20
            checkButton.isHidden = true
        }
    }
    
    func select(isOffline: Bool, takenAsLoad: Bool) {
        self.isOffline = isOffline
        statusLabel.text = isOffline ? "Очно" : "Экстерн"
        loadLabel.text = takenAsLoad ? "В нагрузку" : "Не в нагрузку"
        statusLabel.isHidden = closed
        loadLabel.isHidden = closed
        checkButton.tintColor = Colors.darkgreen.uiColor
        checkButton.setImage(Images.fillCheck.uiImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 23, weight: .medium)), for: .normal)
        isSelected = true
        if !closed && (titleLabel.text ?? "").count > 24 {
            titleLabel.frame.origin.y -= 9
        }
    }
    
    func unSelect() {
        statusLabel.isHidden = true
        loadLabel.isHidden = true
        checkButton.tintColor = .gray
        checkButton.setImage(Images.check.uiImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 23, weight: .medium)), for: .normal)
        isSelected = false
        if !closed {
            titleLabel.frame.origin.y += 9
        }
    }
}
