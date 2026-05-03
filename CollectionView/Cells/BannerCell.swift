//
//  BannerCell.swift
//  CollectionView
//
//  Created by Daniel azmy on 29/04/2026.
//


import UIKit

class BannerCell: UICollectionViewCell {
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
        contentView.addSubview(imageView)
        setupConstrains()
    }
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupConstrains(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func configure(image: UIImage) {
        imageView.image = image
    }
}
