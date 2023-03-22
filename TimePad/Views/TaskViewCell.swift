//
//  TaskViewCell.swift
//  TimePad
//
//  Created by Alief Ahmad Azies on 27/01/23.
//

import UIKit

class TaskViewCell: UITableViewCell {
    private weak var containerView: UIView!
    weak var timeLabel: UILabel!
    private weak var categoryStackVIew: UIStackView!
    private weak var progressImageView: UIImageView!
    weak var nameLabel: UILabel!
    
    var tagType: Tag? {
        didSet { setupCategories() }
    }
    
    var categoryType: Category? {
        didSet { setupCategories() }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupColor()
    }
    
    func setup() {
        selectionStyle = .none
        
        let containerView = UIView(frame: .zero)
        contentView.addSubview(containerView)
        self.containerView = containerView
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        
        let timeLabel = UILabel(frame: .zero)
        containerView.addSubview(timeLabel)
        self.timeLabel = timeLabel
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
        ])
        timeLabel.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        
        let categoryStackView = UIStackView()
        containerView.addSubview(categoryStackView)
        self.categoryStackVIew = categoryStackView
        categoryStackView.axis = .horizontal
        categoryStackView.alignment = .fill
        categoryStackView.distribution = .fill
        categoryStackView.spacing = 4
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            categoryStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16)
        ])
        
        let progressImageView = UIImageView(image: UIImage(named:"icon_progress"))
        containerView.addSubview(progressImageView)
        self.progressImageView = progressImageView
        progressImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            progressImageView.widthAnchor.constraint(equalToConstant: 12),
            progressImageView.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        let nameLabel = UILabel(frame: .zero)
        containerView.addSubview(nameLabel)
        self.nameLabel = nameLabel
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: progressImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            nameLabel.centerYAnchor.constraint(equalTo: progressImageView.centerYAnchor)
            
        ])
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)

        setupColor()
    }
    
    func setupColor() {
        backgroundColor = .clear
        
        if #available(iOS 12.0, *) {
            containerView.backgroundColor = traitCollection.userInterfaceStyle == .dark ? UIColor.cellBackgroundDark : UIColor.cellBackgroundLight
        } else {
            // Fallback on earlier versions
            containerView.backgroundColor = UIColor.cellBackgroundLight
        }
    }
 
    func setupCategories() {
        categoryStackVIew.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let isDark: Bool
        if #available(iOS 12.0, *) {
            isDark = traitCollection.userInterfaceStyle == .dark
        } else {
            isDark = false
        }
        
        let categoryButton = UIButton(type: .system)
        categoryButton.setTitle(categoryType?.name, for: .normal)
        categoryButton.setTitleColor(categoryType?.titleColor, for: .normal)
        categoryButton.backgroundColor = isDark ? categoryType?.backgroundDarkColor : categoryType?.backgroundColor
        categoryButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        categoryButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        categoryButton.isUserInteractionEnabled = false
        categoryButton.layer.cornerRadius = 6
        categoryButton.layer.masksToBounds = true
        categoryStackVIew.addArrangedSubview(categoryButton)
        
        let tagButton = UIButton(type: .system)
        tagButton.setTitle(tagType?.name, for: .normal)
        tagButton.setTitleColor(tagType?.titleColor, for: .normal)
        tagButton.backgroundColor = isDark ? tagType?.backgroundDarkColor : tagType?.backgroundColor
        tagButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        tagButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        tagButton.isUserInteractionEnabled = false
        tagButton.layer.cornerRadius = 6
        tagButton.layer.masksToBounds = true
        categoryStackVIew.addArrangedSubview(tagButton)
    }
}
