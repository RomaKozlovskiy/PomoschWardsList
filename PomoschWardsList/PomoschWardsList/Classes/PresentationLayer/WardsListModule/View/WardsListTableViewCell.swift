//
//  WardsListTableViewCell.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 25.01.2024.
//

import UIKit
import SnapKit
import Kingfisher

private enum Constants {
    static let rowHeight: CGFloat = 60
    static let cellInset = 10
    static let wardPhotoFrame = Int(rowHeight) - cellInset * 2
    static let wardsFullNameFontSize: CGFloat = 17
    static let cityLabelFontSize: CGFloat = 14
}

final class WardsListTableViewCell: UITableViewCell {
    
    // MARK: - UI Propersies
    
    private lazy var wardPhoto: UIImageView = {
        let wardsPhoto = UIImageView()
        wardsPhoto.clipsToBounds = true
        wardsPhoto.contentMode = .scaleAspectFill
        wardsPhoto.layer.cornerRadius = CGFloat(Constants.wardPhotoFrame / 2)
        return wardsPhoto
    }()
    
    private lazy var wardFullName: UILabel = {
        let wardsFullName = UILabel()
        wardsFullName.font = UIFont.systemFont(ofSize: Constants.wardsFullNameFontSize, weight: .regular)
        wardsFullName.numberOfLines = 2
        return wardsFullName
    }()
    
    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.font = UIFont.systemFont(ofSize: Constants.cityLabelFontSize, weight: .regular)
        cityLabel.textColor = .gray
        cityLabel.numberOfLines = 2
        return cityLabel
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
        wardPhoto.image = nil
        wardFullName.text = nil
    }
  
    // MARK: - Public Methods
    
    static func rowHeight() -> CGFloat {
        Constants.rowHeight
    }
    
    func setupWith(ward: WardModel) {
        wardPhoto.kf.setImage(with: URL(string: ward.photoUrl))
        wardFullName.text = ward.fullName
        cityLabel.text = ward.city
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        addSubview(wardPhoto)
        addSubview(wardFullName)
        addSubview(cityLabel)
    }
    
    private func applyConstraints() {
        wardPhoto.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(Constants.cellInset)
            $0.width.equalTo(Constants.wardPhotoFrame)
        }
        
        wardFullName.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalTo(wardPhoto.snp.trailing).offset(Constants.cellInset)
            $0.trailing.equalToSuperview().inset(Constants.cellInset)
        }
        
        cityLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(wardPhoto.snp.trailing).offset(Constants.cellInset)
            $0.trailing.equalToSuperview().inset(Constants.cellInset)
        }
    }
}
