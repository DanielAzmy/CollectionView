//
//  BannerCell.swift
//  CollectionView
//
//  Created by Daniel azmy on 29/04/2026.
//


import UIKit

class HomeHeaderBannerCell: UICollectionViewCell {
    static let identifier = "BannerCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
        setupConstrains()
    }
    required init?(coder: NSCoder) { fatalError("view controller has not been implemented") }
    
    private func setupSubViews(){
        contentView.addSubview(imageView)
    }
    
    private func setupConstrains(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func configure(image: String) {
        imageView.image = UIImage(named: image)
    }
}
