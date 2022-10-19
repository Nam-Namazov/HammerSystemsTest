//
//  MenuViewController.swift
//  HammersSystemTestApp
//
//  Created by Намик on 10/17/22.
//

import UIKit
import SnapKit

final class MenuViewController: UIViewController {
    
    var presenter: MenuPresenterInput?
    
    private var prevIndex = 0
    
    private let cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.font = UIFont.systemFont(ofSize: 17)
        cityLabel.text = "Москва"
        return cityLabel
    }()
    
    private let cityPickerButton: UIButton = {
        let cityPickerButton = UIButton()
        cityPickerButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        cityPickerButton.tintColor = .black
        return cityPickerButton
    }()
    
    private lazy var bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 300,
                                 height: 115)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
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
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var coctailListTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        configureUI()
        layout()
        callPresenter()
    }
    
    private func callPresenter() {
        presenter?.getData()
        presenter?.getImage()
    }
    
    private func style() {
        view.backgroundColor = .systemGray6
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
        coctailListTableView.layer.cornerRadius = 15
        coctailListTableView.clipsToBounds = true
        coctailListTableView.backgroundColor = .clear
    }
    
    private func layout() {
        view.addSubview(bannerCollectionView)
        view.addSubview(categoryCollectionView)
        view.addSubview(coctailListTableView)
        view.addSubview(cityLabel)
        view.addSubview(cityPickerButton)
   
        bannerCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(7)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view)
            make.height.equalTo(112)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(bannerCollectionView.snp.bottom).offset(24)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view)
            make.height.equalTo(32)
        }
        
        coctailListTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalTo(view)
        }
        
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(bannerCollectionView.snp.top).offset(-39)
            make.leading.equalTo(view).offset(16)
        }

        cityPickerButton.snp.makeConstraints { make in
            make.top.equalTo(bannerCollectionView.snp.top).offset(-39)
            make.leading.equalTo(cityLabel.snp.trailing).offset(8)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView === bannerCollectionView {
            return 3
        } else {
            return presenter?.numberOfCategories() ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === bannerCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCollectionViewCell.identifier,
                for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCollectionViewCell.identifier,
                for: indexPath) as? CategoryCollectionViewCell,
                  let category = presenter?.categoryModel(at: indexPath.row) else {
                return UICollectionViewCell()
            }
            cell.configure(withDrink: category)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if collectionView === categoryCollectionView,
           let category = presenter?.categoryModel(at: indexPath.row),
           let index = presenter?.firstIndexOfDrink(with: category)  {
            coctailListTableView.scrollToRow(
                at: IndexPath(row: index, section: 0),
                at: .top,
                animated: false
            )
        }
    }
}

// MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfDrinks() ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CoctailListTableViewCell.identifier,
            for: indexPath) as? CoctailListTableViewCell,
              let drink = presenter?.drinkModel(at: indexPath.row) else {
            return UITableViewCell()
        }
        cell.configure(withDrink: drink)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView === coctailListTableView else {
            return
        }
        
        if let firstIndex = coctailListTableView.indexPathsForVisibleRows?.first?.row,
           let drink = presenter?.drinkModel(at: firstIndex),
           let category = drink.strCategory,
           let indexOfCategory = presenter?.indexOfCategory(category) {
            
            categoryCollectionView.scrollToItem(
                at: IndexPath(row: indexOfCategory, section: 0),
                at: [.centeredVertically, .centeredHorizontally],
                animated: false
            )
            if let cell = categoryCollectionView.cellForItem(
                at: IndexPath(row: prevIndex, section: 0)
            ) {
                cell.contentView.backgroundColor = .white
                cell.contentView.layer.borderWidth = 1
                (cell as? CategoryCollectionViewCell)!.categoryLabel.textColor = UIColor.lightPink
            }
            
            if let cell = categoryCollectionView.cellForItem(
                at: IndexPath(row: indexOfCategory, section: 0)
            ) {
                prevIndex = indexOfCategory
                cell.contentView.backgroundColor = UIColor.categoryBackgroundColor
                cell.contentView.layer.borderWidth = 0
                (cell as? CategoryCollectionViewCell)!.categoryLabel.textColor = UIColor.standardPink
            }
        }
        
        if scrollView.contentOffset.y >= 100 {
            categoryCollectionView.snp.remakeConstraints { make in
                make.top.equalTo(bannerCollectionView)
                make.leading.equalTo(view).offset(16)
                make.trailing.equalTo(view)
                make.height.equalTo(32)
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                self.bannerCollectionView.isHidden = true
                self.view.layoutIfNeeded()
            })
            
        } else {
            categoryCollectionView.snp.remakeConstraints { make in
                make.top.equalTo(bannerCollectionView.snp.bottom).offset(24)
                make.leading.equalTo(view).offset(16)
                make.trailing.equalTo(view)
                make.height.equalTo(32)
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                self.bannerCollectionView.isHidden = false
                self.view.layoutIfNeeded()
            })
        }
    }
}

// MARK: - MenuPresenterOutput
extension MenuViewController: MenuPresenterOutput {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.coctailListTableView.reloadData()
            self.categoryCollectionView.reloadData()
        }
    }
}
