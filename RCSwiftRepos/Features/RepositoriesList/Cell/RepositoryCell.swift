//
//  RepositoryCell.swift
//  RCSwiftRepos
//
//  Created by Renan Cargnin on 27/04/19.
//  Copyright © 2019 Renan Cargnin. All rights reserved.
//

import UIKit
import SnapKit

class RepositoryCell: UITableViewCell {

    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "star"))
        return imageView
    }()
    
    private let starsCountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let ownerAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let ownerNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    private var viewModel: RepositoryCellViewModel?
}

//-----------------------------------------------------------------------------
// MARK: - Overrides
//-----------------------------------------------------------------------------

extension RepositoryCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureConstraints()
    }
}

//-----------------------------------------------------------------------------
// MARK: - Public methods
//-----------------------------------------------------------------------------

extension RepositoryCell {
    
    func configure(with viewModel: RepositoryCellViewModel) {
        self.viewModel = viewModel
        
        nameLabel.text = viewModel.name
        starsCountLabel.text = viewModel.starsCountText
        
        ownerAvatarImageView.sd_setImage(with: viewModel.ownerAvatarURL) { [weak self] (image, error, _, url) in
            guard url == self?.viewModel?.ownerAvatarURL else { return }
            
            self?.ownerAvatarImageView.image = image
        }
        ownerAvatarImageView.sd_setImage(with: viewModel.ownerAvatarURL)
        
        ownerNameLabel.text = viewModel.ownerName
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods
//-----------------------------------------------------------------------------

extension RepositoryCell {
    
    private func configureConstraints() {
        let defaultSpacing: CGFloat = 8
        
        let nameLabelAndStarsContainerView = UIView()
        nameLabelAndStarsContainerView.backgroundColor = .clear
        
        contentView.addSubview(nameLabelAndStarsContainerView)
        nameLabelAndStarsContainerView.snp.makeConstraints {
            $0.leading.equalTo(defaultSpacing)
            $0.centerY.equalToSuperview()
        }
        
        nameLabelAndStarsContainerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        nameLabelAndStarsContainerView.addSubview(starImageView)
        starImageView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(defaultSpacing)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        nameLabelAndStarsContainerView.addSubview(starsCountLabel)
        starsCountLabel.snp.makeConstraints {
            $0.leading.equalTo(starImageView.snp.trailing).offset(defaultSpacing)
            $0.centerY.equalTo(starImageView.snp.centerY)
        }
        
        contentView.addSubview(ownerAvatarImageView)
        ownerAvatarImageView.snp.makeConstraints {
            let side: CGFloat = 44
            $0.width.equalTo(side)
            $0.height.equalTo(side)

            $0.top.equalTo(defaultSpacing)
            $0.leading.equalTo(nameLabelAndStarsContainerView.snp.trailing).offset(defaultSpacing)
            $0.trailing.equalTo(-defaultSpacing)
        }
        
        contentView.addSubview(ownerNameLabel)
        ownerNameLabel.snp.makeConstraints {
            $0.top.equalTo(ownerAvatarImageView.snp.bottom).offset(defaultSpacing)
            $0.trailing.equalTo(ownerAvatarImageView.snp.trailing)
            $0.bottom.equalTo(-defaultSpacing)
        }
    }
}
