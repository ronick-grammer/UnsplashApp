//
//  ProfileCell.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/07.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class ProfileCell: UICollectionViewCell {
    
    private var viewModel: ProfileCellViewModel?
    private let disposeBag = DisposeBag()
    
    private var liked = false
    
    private var photo: WebImageView = {
        let imageView = WebImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10

        return imageView
    }()

    private var ownerName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: label.font.fontName, size: 22)
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
    
    private var likeButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
//        button.translatesAutoresizingMaskIntoConstraints = false

        return button
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
        contentView.isUserInteractionEnabled = true
        
        contentView.addSubview(photo)
        contentView.addSubview(vStackView)

        photo.snp.makeConstraints { maker in
            maker.top.leading.trailing.equalToSuperview()
            maker.bottom.equalToSuperview().dividedBy(1.17)
        }
        
        vStackView.addArrangedSubview(ownerName)
        vStackView.addArrangedSubview(likes)
        vStackView.addArrangedSubview(likeButton)
        
        likeButton.snp.makeConstraints { maker in
            maker.width.height.equalTo(25)
        }
        
        vStackView.snp.makeConstraints { maker in
            maker.width.equalToSuperview().dividedBy(1.3)
            maker.centerX.equalToSuperview()
            maker.centerY.equalTo(photo.snp.bottom).offset(-25)
        }
        
        likeButton.addTarget(self, action: #selector(toggleLike(_:)), for: .touchUpInside)
        
    }

    func configure(photo: Photo) {
        
        viewModel = ProfileCellViewModel(photo: photo)
        
        viewModel?.photo.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] photoInstance in
                
                self?.photo.imageUrl = photoInstance.photo.imageUrl
                self?.ownerName.text = photoInstance.user.name
                self?.likes.text = String(photoInstance.likes)
                self?.liked = photoInstance.liked_by_user
                
                self?.likeButton.setImage(
                    photoInstance.liked_by_user ? UIImage(systemName: "bolt.heart.fill")! : UIImage(systemName: "bolt.heart")!,
                    for: .normal
                )
                
            }).disposed(by: disposeBag)
        
    }
    
    @objc func toggleLike(_ sender: UIButton) {
        liked ? viewModel?.unlike() : viewModel?.like()
    }
    
}

#if DEBUG
import SwiftUI

struct ProfileCell_Preview: PreviewProvider {
    
    static var previews: some View {
        
        UIViewPreview {
            
            let cell = ProfileCell()
//            cell.configure(photo: UIImage(named: "restaurant_1")!, name: "Nicolas Lobos", likes: 53)
//
            return cell
            
        }.previewLayout(.fixed(width: 300, height: 300))
        
    }
    
}

#endif
