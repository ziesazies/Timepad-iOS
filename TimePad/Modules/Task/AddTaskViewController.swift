//
//  AddTaskViewController.swift
//  TimePad
//
//  Created by Alief Ahmad Azies on 27/02/23.
//

import UIKit
import RealmSwift

class AddTaskViewController: BaseViewController {
    weak var titleTitleLabel: UILabel!
    weak var titleTextField: UITextField!
    
    weak var categoryTitleLabel: UILabel!
    weak var categoryStackView: UIStackView!
    
    weak var tagTitleLabel: UILabel!
    weak var tagStackView: UIStackView!
    
    
    weak var saveButton: UIButton!
    
    var selectedCategory: Category?
    var selectedTag: Tag?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func setup() {
        title = "Add New Task"
        
        let titleTitleLabel = UILabel(frame: .zero)
        view.addSubview(titleTitleLabel)
        self.titleTitleLabel = titleTitleLabel
        titleTitleLabel.text = "Task Title"
        titleTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        if #available(iOS 11.0, *) {
            titleTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        } else {
            titleTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.layoutMargins.top + 16).isActive = true
        }
        
        let titleTextField = UITextField(frame: .zero)
        view.addSubview(titleTextField)
        self.titleTextField = titleTextField
        titleTextField.placeholder = "Title"
        titleTextField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleTextField.borderStyle = .none
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleTextField.topAnchor.constraint(equalTo: titleTitleLabel.bottomAnchor, constant: 4),
            titleTextField.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        let line = UIView(frame: .zero)
        view.addSubview(line)
        if #available(iOS 13.0, *) {
            line.backgroundColor = UIColor.separator
        } else {
            // Fallback on earlier versions
            line.backgroundColor = UIColor.lightGray
        }
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(equalToConstant: 1),
            line.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            line.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            line.bottomAnchor.constraint(equalTo: titleTextField.bottomAnchor)
        ])
        
        let categoryTitleLabel = UILabel(frame: .zero)
        view.addSubview(categoryTitleLabel)
        self.categoryTitleLabel = categoryTitleLabel
        categoryTitleLabel.text = "Category"
        categoryTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        categoryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoryTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            categoryTitleLabel.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 16),
        ])
        
        let categoryStackView = UIStackView()
        view.addSubview(categoryStackView)
        self.categoryStackView = categoryStackView
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoryStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
            categoryStackView.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: 8),
        ])
        categoryStackView.axis = .horizontal
        categoryStackView.distribution = .fill
        categoryStackView.alignment = .fill
        categoryStackView.spacing = 12
        
        let categories = Category.allCases
        for i in 0..<categories.count {
            let category = categories[i]
            let button = UIButton(type: .system)
            categoryStackView.addArrangedSubview(button)
            button.setImage(category.icon.withRenderingMode(.alwaysOriginal), for: .normal)
            button.setTitle(nil, for: .normal)
            button.layer.cornerRadius = 22
            button.layer.masksToBounds = true
            button.tag = i
            button.addTarget(self, action: #selector(self.categoryButtonTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 44),
                button.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        let tagTitleLabel = UILabel(frame: .zero)
        view.addSubview(tagTitleLabel)
        self.categoryTitleLabel = tagTitleLabel
        tagTitleLabel.text = "Tag"
        tagTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        tagTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tagTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tagTitleLabel.topAnchor.constraint(equalTo: categoryStackView.bottomAnchor, constant: 16),
        ])

        let tagStackView = UIStackView()
        view.addSubview(tagStackView)
        self.tagStackView = tagStackView
        tagStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tagStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
            tagStackView.topAnchor.constraint(equalTo: tagTitleLabel.bottomAnchor, constant: 8),
        ])
        tagStackView.axis = .horizontal
        tagStackView.alignment = .fill
        tagStackView.distribution = .fill
        tagStackView.spacing = 12

        let tags = Tag.allCases
        for i in 0..<tags.count {
            let tag = tags[i]
            let button = UIButton(type: .system)
            tagStackView.addArrangedSubview(button)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
            button.layer.cornerRadius = 6
            button.layer.masksToBounds = true
            button.tintColor = tag.titleColor
            if #available(iOS 12.0, *) {
                button.backgroundColor = traitCollection.userInterfaceStyle == .dark ? tag.backgroundDarkColor : tag.backgroundColor
            } else {
                // Fallback on earlier versions
                button.backgroundColor = tag.backgroundColor
            }
            button.setTitle(tag.name, for: .normal)
            button.tag = i
            button.addTarget(self, action: #selector(self.tagButtonTapped(_:)), for: .touchUpInside)
        }

        let saveButton = UIButton(type: .system)
        self.saveButton = saveButton
        view.addSubview(saveButton)
        saveButton.setTitle("Save", for: .normal)
        let isDark: Bool
        if #available(iOS 12.0, *) {
            isDark = traitCollection.userInterfaceStyle == .dark
        } else {
            isDark = false
        }
        saveButton.setTitleColor(isDark ? UIColor.white : UIColor(rgb: 0x070417), for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        saveButton.backgroundColor = isDark ? UIColor(rgb: 0x1B143F) : UIColor(rgb: 0xE9E9FF)
        saveButton.addTarget(self, action: #selector(self.saveButtonTapped(_:)), for: .touchUpInside)
        saveButton.layer.cornerRadius = 8
        saveButton.layer.masksToBounds = true
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            saveButton.heightAnchor.constraint(equalToConstant: 60),
        ])
        if #available(iOS 11.0, *) {
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        } else {
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        }
        
    }
    
    @objc func categoryButtonTapped(_ sender: UIButton) {
        let categories = Category.allCases
        let category = categories[sender.tag]
        
        selectedCategory = category
        categoryStackView.arrangedSubviews.forEach { view in
            guard let button = view as? UIButton else {
                print("guard called")
                return
            }
            button.isEnabled = button != sender
            if button.isEnabled {
                button.layer.borderColor = UIColor.clear.cgColor
                button.layer.borderWidth = 0
            }
            else {
                let isDark: Bool
                if #available(iOS 12.0, *) {
                    isDark = traitCollection.userInterfaceStyle == .dark
                } else {
                    isDark = false
                }
                button.layer.borderColor = (isDark ? UIColor.white : UIColor.darkGray).cgColor
                button.layer.borderWidth = 2
            }
        }
    }
    
    // MARK: - Helpers
    func save() {
        let presentAlert: (String) -> Void = { (message) in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        guard let title = titleTextField.text, !title.isEmpty else {
            presentAlert("Please fill the title")
            return
        }
        
        guard let category = selectedCategory?.name else {
            presentAlert("Please choose the category")
            return
        }
        
        guard let tag = selectedTag?.name else {
            presentAlert("Please choose the tag")
            return
        }
        
        let task = Task()
        task.title = title
        task.category = category
        task.tag = tag
        let realm = try! Realm()
        try! realm.write {
            realm.add(task)
        }
        
        print("realm is located at", realm.configuration.fileURL!)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @objc func tagButtonTapped(_ sender: UIButton) {
        let tags = Tag.allCases
        let tag = tags[sender.tag]
        selectedTag = tag
        tagStackView.arrangedSubviews.forEach { view in
            let button = view as! UIButton
            button.isEnabled = button != sender
            if button.isEnabled {
                button.layer.borderColor = UIColor.clear.cgColor
                button.layer.borderWidth = 0
            }
            else {
                button.layer.borderColor = tag.titleColor.cgColor
                button.layer.borderWidth = 2
            }
        }
    }


    @objc func saveButtonTapped(_ sender: UIButton) {
        save()
    }
}

// MARK: - UIViewController
extension UIViewController {
    func presentAddTaskViewController() {
        let viewController = AddTaskViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        present(navigationController, animated: true)
    }
}
