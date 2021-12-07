//
//  ProfileCell.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/07.
//

import Foundation
import UIKit
import SnapKit

class ProfileCell: UICollectionViewCell {
    
    private var photo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10

        return imageView
    }()

    private var ownerName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: label.font.fontName, size: 25)
        label.textColor = .black

        return label
    }()

    // 좋아요 갯수
    private var likes: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: label.font.fontName, size: 20)
        label.textColor = .black

        return label
    }()

    // 좋아요 이미지
    private var likeImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "bolt.heart.fill")!)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    } ()

    private var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.backgroundColor = .gray.withAlphaComponent(0.5)
        stackView.layer.cornerRadius = 15
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setUpLayout()
    }


    private func setUpLayout() {
        contentView.addSubview(photo)
        contentView.addSubview(vStackView)

        photo.snp.makeConstraints { maker in
            maker.top.leading.trailing.equalToSuperview()
            maker.bottom.equalToSuperview().dividedBy(1.17)
//            maker.height.equalTo(300)
        }

        vStackView.addArrangedSubview(ownerName)
        vStackView.addArrangedSubview(likes)
        vStackView.addArrangedSubview(likeImage)

        likeImage.snp.makeConstraints { maker in
            maker.width.height.equalTo(25)
        }
        
        vStackView.snp.makeConstraints { maker in
            maker.width.equalToSuperview().dividedBy(1.5)
            maker.centerX.equalToSuperview()
            maker.centerY.equalTo(photo.snp.bottom)
        }

    }

    func configure(photo: UIImage, name: String, likes: Int) {
        self.photo.image = photo
        self.ownerName.text = name
        self.likes.text = String(likes)
    }
    
}

#if DEBUG
import SwiftUI

struct ProfileCell_Preview: PreviewProvider {
    
    static var previews: some View {
        
        UIViewPreview {
            
            let cell = ProfileCell()
            cell.configure(photo: UIImage(named: "restaurant_1")!, name: "Nicolas Lobos", likes: 53)
         
            return cell
            
        }.previewLayout(.fixed(width: 300, height: 300))
        
    }
    
}

#endif
