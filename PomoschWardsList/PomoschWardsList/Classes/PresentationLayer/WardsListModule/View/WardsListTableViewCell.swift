//
//  WardsListTableViewCell.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 25.01.2024.
//

import UIKit
import SnapKit

private enum Constants {
    static let rowHeight: CGFloat = 70
    static let cellInset = 10
    static let wardPhotoFrame = Int(rowHeight) - cellInset * 2
}

final class WardsListTableViewCell: UITableViewCell {
    
    // MARK: - UI Propersies
    
    private lazy var wardsPhoto: UIImageView = {
        let wardsPhoto = UIImageView()
        wardsPhoto.clipsToBounds = true
        wardsPhoto.contentMode = .scaleAspectFill
        wardsPhoto.layer.cornerRadius = CGFloat(Constants.wardPhotoFrame / 2)
        return wardsPhoto
    }()
    
    private lazy var wardsFullName: UILabel = {
        let wardsFullName = UILabel()
        wardsFullName.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        wardsFullName.numberOfLines = 2
        return wardsFullName
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    
    override func prepareForReuse() {
        wardsPhoto.image = nil
        wardsFullName.text = nil
    }
  
    // MARK: - Public Methods
    
    static func rowHeight() -> CGFloat {
        Constants.rowHeight
    }
    
    func setupWith(ward: WardListModel) {
        wardsPhoto.loadPhotoFrom(stringUrl: ward.photoUrl)
        wardsFullName.text = ward.fullName
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        addSubview(wardsPhoto)
        addSubview(wardsFullName)
    }
    
    private func applyConstraints() {
        wardsPhoto.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(Constants.cellInset)
            $0.width.equalTo(Constants.wardPhotoFrame)
        }
        
        wardsFullName.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(wardsPhoto.snp.trailing).offset(Constants.cellInset)
            $0.trailing.equalToSuperview().inset(Constants.cellInset)
        }
    }
}
