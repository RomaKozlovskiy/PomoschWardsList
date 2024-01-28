//
//  WardInfoViewController.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 26.01.2024.
//

// MARK: - Import

import UIKit
import WardsAPI

// MARK: - WardInfoViewProtocol

protocol WardInfoViewProtocol: AnyObject {
    func showWardInfo(with ward: WardsListQuery.Data.Wards.Edge.Node.PublicInformation, yearsOfLife: String)
}
// MARK: - WardInfoViewController

final class WardInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: WardInfoPresenterProtocol!
    
    private lazy var wardPhoto: UIImageView = _wardPhoto
    private lazy var scrollView: UIScrollView = _scrollView
    private lazy var contentView: UIView = _contentView
    private lazy var stackView: UIStackView = _stackView
    private lazy var fullNameLabel: UILabel = _fullNameLabel
    private lazy var yearsOfLifeLabel: UILabel = _yearsOfLifeLabel
    private lazy var cityLabel: UILabel = _cityLabel
    private lazy var storyLabel: UILabel = _storyLabel
    
    
    // MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
      //  applyConstraints()
       // presenter?.viewDidLoaded()
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        view.addSubview(wardPhoto)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(fullNameLabel)
        stackView.addArrangedSubview(yearsOfLifeLabel)
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(storyLabel)
    }
    
//    private func applyConstraints() {
//        wardPhoto.snp.makeConstraints {
//            $0.height.equalTo(Constants.wardPhotoEdge)
//            $0.width.equalToSuperview()
//            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            $0.centerX.equalToSuperview()
//        }
//        scrollView.snp.makeConstraints {
//            $0.top.equalTo(wardPhoto.snp.bottom).offset(Constants.scrollViewTopOffset)
//            $0.trailing.leading.bottom.equalToSuperview()
//        }
//        
//        contentView.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//            $0.width.equalToSuperview()
//        }
//        
//        stackView.snp.makeConstraints {
//            $0.edges.equalToSuperview().inset(Constants.stackViewInset)
//        }
//    }
}

// MARK: - WardInfoViewProtocol Implementation

extension WardInfoViewController: WardInfoViewProtocol {
    func showWardInfo(
        with ward: WardsAPI.WardsListQuery.Data.Wards.Edge.Node.PublicInformation,
        yearsOfLife: String) {
           // wardPhoto.loadPhotoFrom(stringUrl: ward.photo.url)
            fullNameLabel.text = ward.name.displayName
            yearsOfLifeLabel.text = yearsOfLife
            cityLabel.text = ward.city
            //storyLabel.text = ward.story
        }
}

// MARK: - Private Extension

private extension WardInfoViewController {
    var _wardPhoto: UIImageView  {
        let result = UIImageView()
        result.clipsToBounds = true
        result.contentMode = .scaleAspectFill
        return result
    }
    
    var _scrollView: UIScrollView {
        let result = UIScrollView()
        result.showsVerticalScrollIndicator = false
        return result
    }
    
    var _contentView: UIView {
        let result = UIView()
        return result
    }
    
    var _stackView: UIStackView {
        let result = UIStackView()
        result.axis = .vertical
        result.distribution = .fill
        result.spacing = 5
        return result
    }
    
    var _fullNameLabel: UILabel {
        let result = UILabel()
        result.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return result
    }
    
    var _yearsOfLifeLabel: UILabel {
        let result = UILabel()
        result.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return result
    }
    
    var _cityLabel: UILabel {
        let result = UILabel()
        result.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return result
    }
    
    var _storyLabel: UILabel {
        let result = UILabel()
        result.numberOfLines = 0
        result.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return result
    }
}
