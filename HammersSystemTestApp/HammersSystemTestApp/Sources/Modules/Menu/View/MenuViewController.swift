//
//  MenuViewController.swift
//  HammersSystemTestApp
//
//  Created by Намик on 10/17/22.
//

import UIKit

final class MenuViewController: UIViewController {
    
    private lazy var bannerCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 0
            layout.itemSize = CGSize(width: 300,
                                     height: 115)
            let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: layout)
            return collectionView
        }()
    
    private lazy var categoryCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 0
            layout.itemSize = CGSize(width: 88,
                                     height: 32)
            let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: layout)
            return collectionView
        }()
    
    private let coctailListTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        configureUI()
        layout()
    }
    
    private func style() {
        view.backgroundColor = .white
    }
    
    private func configureUI() {
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(
            BannerCollectionViewCell.self,
            forCellWithReuseIdentifier: BannerCollectionViewCell.identifier
        )
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier
        )
        
        coctailListTableView.delegate = self
        coctailListTableView.dataSource = self
        coctailListTableView.register(
            CoctailListTableViewCell.self,
            forCellReuseIdentifier: CoctailListTableViewCell.identifier
        )
    }
    
    private func layout() {
        view.addSubview(coctailListTableView)
        view.addSubview(bannerCollectionView)
        view.addSubview(categoryCollectionView)
   
        coctailListTableView.translatesAutoresizingMaskIntoConstraints = false
        bannerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
     
        NSLayoutConstraint.activate([
            coctailListTableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 230),
            coctailListTableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            coctailListTableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            coctailListTableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            
            bannerCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            bannerCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            bannerCollectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 7),
            bannerCollectionView.bottomAnchor.constraint(
                equalTo: coctailListTableView.topAnchor,
                constant: -95),
            
            categoryCollectionView.topAnchor.constraint(
                equalTo: bannerCollectionView.bottomAnchor,
                constant: 30),
            categoryCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            categoryCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            categoryCollectionView.bottomAnchor.constraint(
                equalTo: coctailListTableView.topAnchor,
                constant: -15)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.bannerCollectionView {
            return 10
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.bannerCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCollectionViewCell.identifier,
                for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
        }
        
        else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCollectionViewCell.identifier,
                for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CoctailListTableViewCell.identifier,
            for: indexPath) as? CoctailListTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
