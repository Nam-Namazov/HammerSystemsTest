//
//  BannerCollectionViewCell.swift
//  HammersSystemTestApp
//
//  Created by Намик on 10/17/22.
//

import UIKit
import SnapKit

final class BannerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BannerCollectionViewCell"
    
    private var bannerImageView: UIImageView = {
        let bannerImageView = UIImageView()
        bannerImageView.image = UIImage(named: "photo")
        bannerImageView.contentMode = .scaleToFill
        bannerImageView.clipsToBounds = true
        bannerImageView.layer.cornerRadius = 15
        bannerImageView.backgroundColor = .clear
        return bannerImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(bannerImageView)
        bannerImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(contentView)
        }
    }
}
