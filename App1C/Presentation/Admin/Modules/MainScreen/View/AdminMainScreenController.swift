//
//  AdminMainScreenController.swift
//  App1C
//
//  Created by Станислава on 04.04.2024.
//

import UIKit

class AdminMainScreenController: MainScreenViewController {

    private var output: AdminMainScreenViewOutput
    
    private lazy var courseAggregationButton = UIButton()
    
    init(output: AdminMainScreenViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        
        setupCoursesView()
        setupCourseAggregationButton()
        (navigationController as? CustomNavigationController)?.setupBellButton()
    }
    
    override func setupLinksViews() {
        super.setupLinksViews()
        let telegramEditView = UIImageView()
        setupEditView(linkView: telegramView, editView: telegramEditView)
        let chatbotEditView = UIImageView()
        setupEditView(linkView: chatbotView, editView: chatbotEditView)
        let siteEditView = UIImageView()
        setupEditView(linkView: siteView, editView: siteEditView)
        
        let telegramGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(telegramEditButtonTapped))
        telegramEditView.addGestureRecognizer(telegramGestureRecognizer)
        telegramEditView.isUserInteractionEnabled = true
        
        let chatbotGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chatBotEditButtonTapped))
        chatbotEditView.addGestureRecognizer(chatbotGestureRecognizer)
        chatbotEditView.isUserInteractionEnabled = true
        
        let siteGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(siteEditButtonTapped))
        siteEditView.addGestureRecognizer(siteGestureRecognizer)
        siteEditView.isUserInteractionEnabled = true
        
        let openTelegramGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openTelegram))
        let openChatbotGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openChatbot))
        let openSiteGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openSite))
        
        telegramView.isUserInteractionEnabled = true
        chatbotView.isUserInteractionEnabled = true
        siteView.isUserInteractionEnabled = true
        
        telegramView.addGestureRecognizer(openTelegramGestureRecognizer)
        chatbotView.addGestureRecognizer(openChatbotGestureRecognizer)
        siteView.addGestureRecognizer(openSiteGestureRecognizer)
    }
    
    private func setupCoursesView() {
        baseElements.append(BaseModel(id: 4, title: "Курсы кафедры", image: Images.graduationcap.uiImage))
        super.setupBaseView()
        
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: telegramView.bottomAnchor, constant: 20),
        ])
    }
    
    private func setupEditView(linkView: UIView, editView: UIImageView) {
        linkView.addSubview(editView)
        editView.translatesAutoresizingMaskIntoConstraints = false
        
        editView.image = Images.edit.uiImage
        editView.tintColor = Colors.red.uiColor
        editView.backgroundColor = .white
        editView.layer.cornerRadius = 2
        editView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            editView.heightAnchor.constraint(equalToConstant: 27),
            editView.widthAnchor.constraint(equalToConstant: 25),
            editView.leadingAnchor.constraint(equalTo: linkView.trailingAnchor, constant: -17),
            editView.bottomAnchor.constraint(equalTo: linkView.topAnchor, constant: 17)
        ])
        
    }
    
    @objc private func openTelegram() {
        output.openTelegram()
    }
    
    @objc private func openChatbot() {
        output.openChatbot()
    }
    
    @objc private func openSite() {
        output.openSite()
    }
    
    @objc private func courseAggregationButtonTapped() {

    }
    
    @objc func telegramEditButtonTapped() {
        var telegramTextField = UITextField()
        let alertController = createAlertController(title: "Чат кафедры")
        alertController.addTextField() { textField in
            telegramTextField = textField
        }
        alertController.addAction(UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
            self?.output.updateTelegramURL(url: telegramTextField.text ?? "")
        })
        present(alertController, animated: true)
    }
    
    @objc func chatBotEditButtonTapped() {
        var chatbotTextField = UITextField()
        let alertController = createAlertController(title: "Телеграм-бот")
        alertController.addTextField() { textField in
            chatbotTextField = textField
        }
        alertController.addAction(UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
            self?.output.updateChatbotURL(url: chatbotTextField.text ?? "")
        })
        present(alertController, animated: true)
    }
    
    @objc func siteEditButtonTapped() {
        var siteTextField = UITextField()
        let alertController = createAlertController(title: "Сайт")
        alertController.addTextField() { textField in
            siteTextField = textField
        }
        alertController.addAction(UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
            self?.output.updateSiteURL(url: siteTextField.text ?? "")
        })
        present(alertController, animated: true)
    }
    
    private func createAlertController(title: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: "Введите новую ссылку:", preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        alertController.view.tintColor = .black
        alertController.view.backgroundColor = Colors.yellow.uiColor
        alertController.view.layer.cornerRadius = 15
        
        return alertController
    }
}

extension AdminMainScreenController: AdminMainScreenViewInput {
    func setupCourseAggregationButton() {
        courseAggregationButton = ButtonView(frame: .zero)
        view.addSubview(courseAggregationButton)
        courseAggregationButton.translatesAutoresizingMaskIntoConstraints = false
        courseAggregationButton.setTitle("Перейти к запуску курсов", for: .normal)
        
        NSLayoutConstraint.activate([
            courseAggregationButton.topAnchor.constraint(equalTo: baseView.bottomAnchor, constant: 25),
            courseAggregationButton.heightAnchor.constraint(equalToConstant: 45),
            courseAggregationButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            courseAggregationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        courseAggregationButton.addTarget(self, action: #selector(courseAggregationButtonTapped), for: .touchUpInside)
    }
}

extension AdminMainScreenController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let selectedItem = dataSource.itemIdentifier(for: indexPath) {
//            print("Selected item: \(selectedItem)")
//            output.tripDidSelect(model: selectedItem)
//        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

