//
//  CoctailListTableViewCell.swift
//  HammersSystemTestApp
//
//  Created by Намик on 10/17/22.
//

import UIKit

final class CoctailListTableViewCell: UITableViewCell {
    
    static let identifier = "CoctailListTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.backgroundColor = .blue
    }
}
