//
//  ViewController.swift
//  CollectionView
//
//  Created by Daniel azmy on 27/04/2026.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Variables
    private let sections: [Sections] = [.banner, .grids]
    private var images: [[UIImage]] = [
           [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!],
           [UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "1")!],
           [UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!],
       ]

    // MARK: - UI components
    private lazy var stackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [titlee, subTitle])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.alignment = .center
        return stack
    }()
    
    private lazy var tableView: UITableView = {
            let tv = UITableView(frame: .zero, style: .plain)
            tv.dataSource = self
            tv.delegate = self
            tv.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
            tv.register(BannerTableViewCell.self, forCellReuseIdentifier: BannerTableViewCell.identifier)
            tv.separatorStyle = .none
            tv.translatesAutoresizingMaskIntoConstraints = false
            return tv
        }()
    
    private let titlee: UILabel = {
       let label = UILabel()
        label.text = "Collection View"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let subTitle: UILabel = {
       let label = UILabel()
        label.text = "Stack View"
        label.textColor = .systemTeal
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(stackView)
        view.addSubview(tableView)
        view.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            // Item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalWidth(1/3)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
            
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(1/3)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)

            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(60)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top,
                absoluteOffset: CGPoint(x: 0, y: 60)
                
            )
            header.pinToVisibleBounds = true
            section.boundarySupplementaryItems = [header]
            
            return section
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .banner: return 1
        case .grids:   return images.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .banner:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: BannerTableViewCell.identifier,
                for: indexPath
            ) as! BannerTableViewCell
            cell.configure(images: [
                UIImage(named: "b1")!,
                UIImage(named: "b2")!,
                UIImage(named: "b3")!,
            ])
            return cell
            
        case .grids:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CollectionTableViewCell.identifier,
                for: indexPath
            ) as! CollectionTableViewCell
            cell.items = images[indexPath.row]
            return cell
        }
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section] {
        case .banner: return 220 + 4 + 24
        case .grids:   return UITableView.automaticDimension
        }
    }
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Section \(section + 1)"
        }
}


enum Sections{
    case banner
    case grids
}
