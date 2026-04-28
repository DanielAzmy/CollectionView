//
//  CustomCollectionHeaderView.swift
//  CollectionView
//
//  Created by Daniel azmy on 28/04/2026.
//


import UIKit

class CustomCollectionHeaderView: UICollectionReusableView {
    static let identifier = "CustomCollectionHeaderView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configure(title: String, subtitle: String? = nil) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        subtitleLabel.isHidden = subtitle == nil
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        addSubview(stack)
        applyGradient(colors: [.clear, .white], direction: .bottomToTop)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}

extension UIView {
    func applyGradient(colors: [UIColor],
                       direction: GradientDirection = .topToBottom) {
        layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let gradient = CAGradientLayer()
        gradient.colors = colors.map { $0.cgColor }
        gradient.frame = bounds
        
        switch direction {
        case .topToBottom:
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint   = CGPoint(x: 0.5, y: 1)
        case .leftToRight:
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint   = CGPoint(x: 1, y: 0.5)
        case .diagonal:
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint   = CGPoint(x: 1, y: 1)
        case .bottomToTop:
            gradient.startPoint = CGPoint(x: 0.5, y: 1)
            gradient.endPoint   = CGPoint(x: 0.5, y: 0)
        }
        
        layer.insertSublayer(gradient, at: 0)
    }
}

enum GradientDirection {
    case topToBottom
    case bottomToTop
    case leftToRight
    case diagonal
}
