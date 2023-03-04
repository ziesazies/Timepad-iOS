//
//  TabBarView.swift
//  TimePad
//
//  Created by Alief Ahmad Azies on 25/01/23.
//

import UIKit

protocol TabBarViewDelegate: NSObjectProtocol {
    func tabBarView(_ view: TabBarView, didSelectItemAt index: Int)
    func tabBarView(_ view: TabBarView, shouldSelectItemAt index: Int) -> Bool
}

class TabBarView: UIView {
    fileprivate weak var shadowLayer: CAShapeLayer!
    var cornerRadius: CGFloat = 30
    var color: UIColor? = UIColor.white
    var darkColor: UIColor?
    
    fileprivate weak var stackView: UIStackView!
    weak var delegate: TabBarViewDelegate?
    
    convenience init(cornerRadius: CGFloat = 30, color: UIColor? = UIColor.white, darkColor: UIColor? = nil) {
        self.init(frame: .zero)
        self.cornerRadius = cornerRadius
        self.color = color
        self.darkColor = darkColor ?? color
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            let shadowLayer = CAShapeLayer()
            layer.insertSublayer(shadowLayer, at: 0)
            self.shadowLayer = shadowLayer
        }
        
        
        let fillColor: UIColor?
        if #available(iOS 12.0, *) {
            fillColor = traitCollection.userInterfaceStyle == .dark ? darkColor : color
        } else {
            fillColor = color
        }
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        shadowLayer?.fillColor = fillColor?.cgColor
        shadowLayer?.path = path.cgPath
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        shadowLayer?.shadowColor = UIColor(rgb: 0x828282).withAlphaComponent(0.15).cgColor
        shadowLayer?.shadowPath = shadowPath.cgPath
        shadowLayer?.shadowOffset = CGSize(width: 0, height: -8)
        shadowLayer?.shadowOpacity = 1.0
        shadowLayer?.shadowRadius = 100
    }
    
    fileprivate func setup() {
        backgroundColor = .clear
        
        let stackView = UIStackView()
        addSubview(stackView)
        self.stackView = stackView
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 60)])
        
    }
    
    //MARK: - Helpers
    
    var items: [TabBarButton] {
        set {
            stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            newValue.forEach { button in
                stackView.addArrangedSubview(button)
                button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
            }
        }
        get {
            return stackView.arrangedSubviews.compactMap { $0 as? TabBarButton }
        }
    }
    
    @objc fileprivate func buttonTapped(_ sender: TabBarButton) {
        if let index = items.firstIndex(of: sender) {
            selectedIndex = index
        }
    }
    
    var selectedIndex: Int = 0 {
        didSet {
            selectIndex(selectedIndex)
        }
    }
    
    fileprivate func selectIndex(_ index: Int) {
        let items = self.items
        if max(0, index) < items.count {
            if delegate?.tabBarView(self, shouldSelectItemAt: index) == true {
                let selectedButton = items[index]
                items.forEach { button in
                    button.isEnabled = button != selectedButton
                }
            }
            delegate?.tabBarView(self, didSelectItemAt: index)
        }
    }
}
