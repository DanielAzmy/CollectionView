//
//  BannerFooterView.swift
//  CollectionView
//
//  Created by Daniel azmy on 29/04/2026.
//

import UIKit

// MARK: - Footer View
class BannerFooterView: UICollectionReusableView {
    static let identifier = "BannerFooterView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(pageControl: UIPageControl) {
        subviews.forEach { $0.removeFromSuperview() }
        addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
