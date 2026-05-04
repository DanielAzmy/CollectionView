//
//  BannerTableViewCell.swift
//  CollectionView
//
//  Created by Daniel azmy on 29/04/2026.
//

import UIKit

class HomeHeaderViewCell: UITableViewCell {
    static let identifier = "BannerTableViewCell"
    
    private let bannerView: BannerView = {
        let view = BannerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        setupAppearance()
        
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bannerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bannerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    private func setupViews(){
        contentView.addSubview(bannerView)
    }
    private func setupAppearance(){
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func configure(images: [String]) {
        bannerView.configure(images: images)
    }
}
