//
//  BannerCollectionViewCell.swift
//  HammersSystemTestApp
//
//  Created by Намик on 10/17/22.
//

import UIKit

final class BannerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BannerCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 15
    }
}


