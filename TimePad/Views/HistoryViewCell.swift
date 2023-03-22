//
//  HistoryViewCell.swift
//  TimePad
//
//  Created by Alief Ahmad Azies on 27/01/23.
//

import UIKit

protocol HistoryViewCellDelegate: NSObjectProtocol {
    func historyViewCellPlayButtonTapped(_ cell: HistoryViewCell)
}

class HistoryViewCell: UITableViewCell {
    weak var containerView: UIView!
    weak var iconImageView: UIImageView!
    weak var nameLabel: UILabel!
    weak var timeLabel: UILabel!
    weak var categoryStackView: UIStackView!
    weak var playButton: UIButton!
    
    weak var delegate: HistoryViewCellDelegate?
    
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
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        
        let iconImageView = UIImageView(frame: .zero)
        containerView.addSubview(iconImageView)
        self.iconImageView = iconImageView
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 44),
            iconImageView.heightAnchor.constraint(equalToConstant: 44),
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16)
        ])
        
        let nameLabel = UILabel(frame: .zero)
        containerView.addSubview(nameLabel)
        self.nameLabel = nameLabel
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
        ])
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        let timeLabel = UILabel(frame: .zero)
        containerView.addSubview(timeLabel)
        self.timeLabel = timeLabel
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16),
            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
        ])
        timeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        timeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        timeLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        let categoryStackView = UIStackView()
        containerView.addSubview(categoryStackView)
        self.categoryStackView = categoryStackView
        categoryStackView.axis = .horizontal
        categoryStackView.distribution = .fill
        categoryStackView.alignment = .fill
        categoryStackView.spacing = 8
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryStackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            categoryStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            categoryStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        
        let playButton = UIButton(type: .system)
        containerView.addSubview(playButton)
        self.playButton = playButton
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.widthAnchor.constraint(equalToConstant: 24),
            playButton.heightAnchor.constraint(equalToConstant: 24),
            playButton.leadingAnchor.constraint(greaterThanOrEqualTo: categoryStackView.trailingAnchor, constant: 16),
            playButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            playButton.centerYAnchor.constraint(equalTo: categoryStackView.centerYAnchor)
        ])
        playButton.setImage(UIImage(named: "btn_play")?.withRenderingMode(.alwaysOriginal), for: .normal)
        playButton.setTitle(nil, for: .normal)
        playButton.addTarget(self, action: #selector(self.playButtonTapped(_:)), for: .touchUpInside)

        setupColor()
    }
    
    func setupColor() {
        backgroundColor = .clear
        
        if #available(iOS 12.0, *) {
            let isDark = traitCollection.userInterfaceStyle == .dark
           containerView.backgroundColor = isDark ? UIColor.cellBackgroundDark : UIColor.cellBackgroundLight
            timeLabel.textColor = isDark ? UIColor.textGrayDark : UIColor.textGrayLight
        }
        else {
            // Fallback on earlier versions
            containerView.backgroundColor = UIColor.cellBackgroundLight
        }
    }
    
    @objc func playButtonTapped(_ sender: Any) {
        delegate?.historyViewCellPlayButtonTapped(self)
    }
    
    private func setupCategories() {
        categoryStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
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
        categoryStackView.addArrangedSubview(categoryButton)
        
        let tagButton = UIButton(type: .system)
        tagButton.setTitle(tagType?.name, for: .normal)
        tagButton.setTitleColor(tagType?.titleColor, for: .normal)
        tagButton.backgroundColor = isDark ?
        tagType?.backgroundDarkColor : tagType?.backgroundColor
        tagButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        tagButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        tagButton.layer.cornerRadius = 6
        tagButton.layer.masksToBounds = true
        categoryStackView.addArrangedSubview(tagButton)
    }
    
}
