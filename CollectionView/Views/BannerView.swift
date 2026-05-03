//
//  BannerView.swift
//  CollectionView
//
//  Created by Daniel azmy on 29/04/2026.
//

import UIKit

class BannerView: UIView {

    // MARK: - properties
    var images: [UIImage] = []
    var currentPage: Int = 0
    private var autoScrollTimer: Timer?
    
    //MARK: - UI components
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        cv.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        cv.isPagingEnabled = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    private let pageControl: UIPageControl = {
            let pc = UIPageControl()
            pc.currentPageIndicatorTintColor = .systemBlue
            pc.pageIndicatorTintColor = .systemGray4
            pc.translatesAutoresizingMaskIntoConstraints = false
            return pc
        }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI(){
        addSubview(collectionView)
        addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 24),
        ])
        
    }
    
    func configure(images: [UIImage]) {
            self.images = images
            pageControl.numberOfPages = images.count
            pageControl.currentPage = 0
            collectionView.reloadData()
            startAutoScroll()
        }
    
    private func makeLayout() -> UICollectionViewCompositionalLayout {
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging  

            
            section.visibleItemsInvalidationHandler = { [weak self] _, offset, environment in
                guard let self else { return }
                let page = Int((offset.x / environment.container.contentSize.width * CGFloat(self.images.count)).rounded())
                let clamped = max(0, min(page, self.images.count - 1))
                if self.currentPage != clamped {
                    self.currentPage = clamped
                    self.pageControl.currentPage = clamped
                }
            }
            
            return UICollectionViewCompositionalLayout(section: section)
        }

    private func startAutoScroll() {
            autoScrollTimer?.invalidate()
            autoScrollTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
                self?.scrollToNext()
            }
        }
    
    private func scrollToNext() {
            guard !images.isEmpty else { return }
            let next = (currentPage + 1) % images.count
            collectionView.scrollToItem(
                at: IndexPath(item: next, section: 0),
                at: .centeredHorizontally,
                animated: true
            )
        }
        
        deinit {
            autoScrollTimer?.invalidate()
        }
}

extension BannerView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as! BannerCell
        cell.configure(image: images[indexPath.row])
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        autoScrollTimer?.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startAutoScroll()
    }
}
