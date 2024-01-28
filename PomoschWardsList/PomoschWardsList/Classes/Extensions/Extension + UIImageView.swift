//
//  Extension + UIImageView.swift
//  PomoschWardsList
//
//  Created by Роман Козловский on 25.01.2024.
//

// MARK: - Import

import UIKit

// MARK: - Extension UIImageView
//TODO: разобраться как загружать фото в ячейку 
extension UIImageView {
    func loadPhotoFrom(stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: data)  else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
