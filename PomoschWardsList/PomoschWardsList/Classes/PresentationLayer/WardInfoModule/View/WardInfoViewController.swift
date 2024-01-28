//
//  WardInfoViewController.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 26.01.2024.
//

// MARK: - Import

import UIKit
import Kingfisher

private enum Constants {
    static let fullNameLabelFontSize: CGFloat = 23
    static let titleLabelFontSize: CGFloat = 17
    static let storyLabelFontSize: CGFloat = 15
    static let wardPhotoHeight = 300
    static let titleLabelTopOffset: CGFloat = 40
    static let defaultOffset: CGFloat = 15
    static let storyLabelTopOffset: CGFloat = 20
    static let scrollViewBottomInset: CGFloat = 15
    static let titleLabelTitle = "О подопечном"
}

protocol WardInfoViewProtocol: AnyObject {
    func displayWardInfo(with ward: WardInfoModel)
}

final class WardInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: WardInfoPresenterProtocol!
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        return contentView
    }()
   
    private lazy var wardPhoto: UIImageView = {
        let wardPhoto = UIImageView()
        wardPhoto.clipsToBounds = true
        wardPhoto.backgroundColor = .lightGray
        wardPhoto.contentMode = .scaleAspectFill
        return wardPhoto
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.font = UIFont.systemFont(
            ofSize: Constants.fullNameLabelFontSize, weight: .regular)
        return fullNameLabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = Constants.titleLabelTitle
        titleLabel.font = UIFont.systemFont(
            ofSize: Constants.titleLabelFontSize, 
            weight: .regular
        )
        return titleLabel
    }()
    
    private lazy var storyLabel: UILabel = {
        let storyLabel = UILabel()
        storyLabel.numberOfLines = 0
        storyLabel.font = UIFont.systemFont(
            ofSize: Constants.storyLabelFontSize,
            weight: .regular
        )
        storyLabel.textColor = .gray
        return storyLabel
    }()
    
    // MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        applyConstraints()
        presenter?.viewDidLoaded()
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(wardPhoto)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(storyLabel)
    }
    
    private func applyConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Constants.scrollViewBottomInset)
        }
        
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        wardPhoto.snp.makeConstraints {
            $0.height.equalTo(Constants.wardPhotoHeight)
            $0.width.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        fullNameLabel.snp.makeConstraints {
            $0.top.equalTo(wardPhoto.snp.bottom).offset(Constants.defaultOffset)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(fullNameLabel.snp.bottom).offset(Constants.titleLabelTopOffset)
            $0.leading.equalToSuperview().inset(Constants.defaultOffset)
        }
        
        storyLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.storyLabelTopOffset)
            $0.leading.trailing.equalToSuperview().inset(Constants.defaultOffset)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - WardInfoViewProtocol

extension WardInfoViewController: WardInfoViewProtocol {
    func displayWardInfo(with ward: WardInfoModel) {
        wardPhoto.kf.setImage(with: URL(string: ward.photoUrl))
        fullNameLabel.text = ward.fullName
        storyLabel.text = ward.story
    }
}
