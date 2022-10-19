//
//  CoctailListTableViewCell.swift
//  HammersSystemTestApp
//
//  Created by Намик on 10/17/22.
//

import UIKit
import SnapKit

final class CoctailListTableViewCell: UITableViewCell {
    
    static let identifier = "CoctailListTableViewCell"
    
    private let coctailTitleLabel: UILabel = {
        let coctailTitleLabel = UILabel()
        coctailTitleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        coctailTitleLabel.textColor = .black
        return coctailTitleLabel
    }()
    
    private let categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.textColor = .darkGray
        categoryLabel.font = UIFont.systemFont(ofSize: 15)
        return categoryLabel
    }()
    
    private let coctailInstructionTextView: UITextView = {
        let coctailInstructionTextView = UITextView()
        coctailInstructionTextView.font = UIFont.systemFont(ofSize: 13)
        coctailInstructionTextView.textColor = .systemGray
        coctailInstructionTextView.textAlignment = .left
        coctailInstructionTextView.isSelectable = false
        return coctailInstructionTextView
    }()
    
    private let priceButton: UIButton = {
        let priceButton = UIButton()
        priceButton.layer.borderWidth = 1
        priceButton.layer.borderColor = UIColor.red.cgColor
        priceButton.layer.cornerRadius = 5
        priceButton.setTitle("от 345 р", for: .normal)
        priceButton.setTitleColor(UIColor.standardPink, for: .normal)
        priceButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return priceButton
    }()
    
    private let coctailImageView: UIImageView = {
        let coctailImageView = UIImageView()
        coctailImageView.clipsToBounds = true
        coctailImageView.layer.cornerRadius = 132 / 2
        coctailImageView.contentMode = .scaleToFill
        return coctailImageView
    }()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        configureUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withDrink drink: Drink) {
        coctailTitleLabel.text = drink.strDrink
        coctailInstructionTextView.text = drink.strInstructions
        categoryLabel.text = "Category: \(drink.strCategory!)"
        
        if let data = drink.drinkThumbImageData,
           let image = UIImage(data: data) {
            coctailImageView.image = image
        }
    }
    
    private func configureUI() {
        contentView.backgroundColor = .white
    }
    
    private func layout() {
        contentView.addSubview(coctailImageView)
        contentView.addSubview(coctailTitleLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(coctailInstructionTextView)
        contentView.addSubview(priceButton)
        
        coctailImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(24)
            make.leading.equalTo(contentView).offset(16)
            make.height.equalTo(132)
            make.width.equalTo(132)
        }
        
        coctailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(32)
            make.leading.equalTo(coctailImageView.snp.trailing).offset(32)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(coctailTitleLabel.snp.bottom).offset(7)
            make.leading.equalTo(coctailImageView.snp.trailing).offset(32)
            make.trailing.equalTo(contentView).offset(-24)
        }
        
        coctailInstructionTextView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(5)
            make.leading.equalTo(coctailImageView.snp.trailing).offset(29)
            make.trailing.equalTo(contentView).offset(-24)
            make.bottom.equalTo(contentView).offset(-72)
        }
        
        priceButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-24)
            make.top.equalTo(coctailInstructionTextView.snp.bottom).offset(16)
            make.height.equalTo(32)
            make.width.equalTo(87)
        }
    }
}
