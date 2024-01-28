//
//  WardInfoViewController.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 26.01.2024.
//

// MARK: - Import

import UIKit

// MARK: - WardInfoViewProtocol

protocol WardInfoViewProtocol: AnyObject {
    func displayWardInfo(with ward: WardInfoModel)
}
// MARK: - WardInfoViewController

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
        wardPhoto.backgroundColor = .gray
        wardPhoto.contentMode = .scaleAspectFill
        return wardPhoto
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.font = UIFont.systemFont(ofSize: 23, weight: .regular)
        return fullNameLabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = "О подопечном"
        fullNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return fullNameLabel
    }()
    
    private lazy var storyLabel: UILabel = {
        let storyLabel = UILabel()
        storyLabel.numberOfLines = 0
        storyLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        storyLabel.textColor = .gray
        return storyLabel
    }()
    
    
    // MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        wardPhoto.snp.makeConstraints {
            $0.height.equalTo(300) //TODO: Constants
            $0.width.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        fullNameLabel.snp.makeConstraints {
            $0.top.equalTo(wardPhoto.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(fullNameLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(15)
        }
        
        storyLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - WardInfoViewProtocol Implementation

extension WardInfoViewController: WardInfoViewProtocol {
    func displayWardInfo(with ward: WardInfoModel) {
        wardPhoto.kf.setImage(with: URL(string: ward.photoUrl))
        fullNameLabel.text = ward.fullName
        storyLabel.text = ward.story
    }
}
