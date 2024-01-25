//
//  WardsListTableViewCell.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 25.01.2024.
//

// MARK: - Import

import UIKit
import SnapKit
import WardsAPI

// MARK: - WardsListTableViewCell

final class WardsListTableViewCell: UITableViewCell {
    
    // MARK: - UI Propersies
    
    private lazy var wardsPhoto: UIImageView = _wardsPhoto
    private lazy var wardsFullName: UILabel = _wardsFullName
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override properties 
    
    override func prepareForReuse() {
        wardsPhoto.image = nil
        wardsFullName.text = nil
    }
    
    // MARK: - Public Methods
    
    func setupWith(ward: WardsListQuery.Data.Wards.Edge.Node.PublicInformation) {
        wardsPhoto.loadPhotoFrom(stringUrl: ward.photo.url)
        wardsFullName.text = ward.name.displayName
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        addSubview(wardsPhoto)
        addSubview(wardsFullName)
    }
    
    private func applyConstraints() {
        wardsPhoto.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(Constants.tableViewCellInset)
            $0.width.equalTo(Constants.wardPhotoFrame)
        }
        
        wardsFullName.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(wardsPhoto.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}

// MARK: - Private Extension

private extension WardsListTableViewCell {
    var _wardsPhoto: UIImageView  {
        let result = UIImageView()
        result.clipsToBounds = true
        result.contentMode = .scaleAspectFill
        result.layer.cornerRadius = CGFloat(Constants.wardPhotoFrame / 2)
        return result
    }
    
    var _wardsFullName: UILabel {
        let result = UILabel()
        result.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        result.numberOfLines = 2
        return result
    }
}
