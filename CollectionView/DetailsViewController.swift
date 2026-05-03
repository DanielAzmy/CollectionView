//
//  DetailsViewController.swift
//  CollectionView
//
//  Created by Daniel azmy on 03/05/2026.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: - variables
    var image: String
    var text: String
    
    //MARK: - UI components
    private var detailsImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var emptyView: UIView = {
       let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    private lazy var detailsStack: UIStackView = {
       let sv = UIStackView(arrangedSubviews: [detailsImage, titleLabel, emptyView])
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        return sv
    }()
    
    init(image: String, title: String){
        self.image = image
        self.text = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    private func setupViews(){
        detailsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailsStack)
        view.backgroundColor = .white
        detailsImage.image = UIImage(named: image)
        titleLabel.text = text
    }
    
    private func setupNavigationBar(){
        title = text
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            detailsStack.topAnchor.constraint(equalTo: view.topAnchor),
            detailsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            detailsImage.widthAnchor.constraint(equalTo: detailsStack.widthAnchor),
            
            emptyView.heightAnchor.constraint(equalToConstant: 450)
        ])
    }

}
