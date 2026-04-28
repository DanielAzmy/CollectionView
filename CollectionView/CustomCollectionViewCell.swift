//
//  CustomCollectionViewCell.swift
//  CollectionView
//
//  Created by Daniel azmy on 27/04/2026.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "questionmark")
        image.tintColor = .white
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false  // ← required
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage) {
        imageView.image = image
    }
    
    private func setupUi() {
        contentView.backgroundColor = .blue
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
