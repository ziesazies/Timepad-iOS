//
//  TaskViewController.swift
//  TimePad
//
//  Created by Alief Ahmad Azies on 09/03/23.
//

import UIKit
import RealmSwift

class TaskViewController: BaseViewController {
    
    weak var finishButton: UIButton!
    private weak var progressImageView: UIImageView!
    weak var nameLabel: UILabel!
    
    var task: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        let isDark: Bool
        if #available(iOS 12.0, *) {
            isDark = traitCollection.userInterfaceStyle == .dark
        } else {
            isDark = false
        }
        
        if #available(iOS 13.0, *) {
            // Do nothing
        }
        else {
            addCloseButton()
        }
        
        title = task.categoryType?.name
        
        let tag = task.tagType
        let tagButton = UIButton(type: .system)
        tagButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        tagButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        tagButton.layer.cornerRadius = 6
        tagButton.layer.masksToBounds = true
        tagButton.tintColor = tag?.titleColor
        if #available(iOS 12.0, *) {
            tagButton.backgroundColor = traitCollection.userInterfaceStyle == .dark ? tag?.backgroundDarkColor : tag?.backgroundColor
        }
        else {
            tagButton.backgroundColor = tag?.backgroundColor
        }
        tagButton.setTitle(tag?.name, for: .normal)
        tagButton.isUserInteractionEnabled = false
        let barButtonItem = UIBarButtonItem(customView: tagButton)
        navigationItem.rightBarButtonItem = barButtonItem
        
        
        let progressImageView: UIImageView = UIImageView(image: UIImage(named: "icon_progress"))
        view.addSubview(progressImageView)
        self.progressImageView = progressImageView
        progressImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressImageView.widthAnchor.constraint(equalToConstant: 12),
            progressImageView.heightAnchor.constraint(equalToConstant: 12),
            progressImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        let nameLabel = UILabel(frame: .zero)
        view.addSubview(nameLabel)
        self.nameLabel = nameLabel
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: progressImageView.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: progressImageView.centerYAnchor)
        ])
        if #available(iOS 11.0, *){
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        } else {
            //fallback on earlier versions
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.layoutMargins.top + 16).isActive = true
        }
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        nameLabel.text = task.title
        
        let finishButton = UIButton(type: .system)
        view.addSubview(finishButton)
        self.finishButton = finishButton
        finishButton.setTitle(task.start == nil ? "Start" : "Finish", for: .normal)
        
        finishButton.setTitleColor(isDark ? UIColor.white : UIColor(rgb: 0x070417), for: .normal)
        finishButton.backgroundColor = isDark ? UIColor(rgb: 0x1B143F) : UIColor(rgb: 0xE9E9FF)
        finishButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        finishButton.layer.cornerRadius = 8
        finishButton.layer.masksToBounds = true
        finishButton.addTarget(self, action: #selector(self.finishButtonTapped(_:)), for: .touchUpInside)
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            finishButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        if #available(iOS 11.0, *) {
            finishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        }
        else{
            //fallback to previous versions
            finishButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        }
    }
    
    // MARK: - Helpers
    
    func start() {
        
    }
    
    func finish() {
        
    }
    
    // MARK: - Actions
    
    @objc func finishButtonTapped(_ sender: UIButton) {
        if task.start == nil {
            start()
        }
        else {
            finish()
        }
    }
}

// MARK: - UIViewController
extension UIViewController {
    func presentTaskViewController(task: Task) {
        let viewController = TaskViewController()
        viewController.task = task
        let navigationController = UINavigationController(rootViewController: viewController)
        
        present(navigationController, animated: true, completion: nil)
        
    }
}
