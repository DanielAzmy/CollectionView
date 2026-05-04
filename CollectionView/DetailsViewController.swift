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
    private lazy var scrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
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
        label.backgroundColor = .white
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
        sv.spacing = 12
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
        view.addSubview(scrollView)
        scrollView.addSubview(detailsStack)
        
        view.backgroundColor = .white
        detailsImage.image = UIImage(named: image)
        
        titleLabel.text = text
    }
    
    private func setupNavigationBar(){
        title = "Image details"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            detailsStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            detailsStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            detailsStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 12),
            detailsStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 12),
            detailsStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            detailsImage.heightAnchor.constraint(equalTo: detailsImage.widthAnchor),
        ])
    }

}
