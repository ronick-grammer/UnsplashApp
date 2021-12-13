//
//  SearchCell.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/06.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchCell: UITableViewCell {
    
    var viewModel: SearchCellViewModel?
    let disposeBag = DisposeBag()
    
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
    
    // 좋아요 이미지
    private var likeButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    private var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.backgroundColor = .white.withAlphaComponent(0.5)
        stackView.layer.cornerRadius = 15
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    var liked = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        backgroundView = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 500, left: 0, bottom: 800, right: 0))
    }
    
    private func setUp() {
        contentView.isUserInteractionEnabled = true
        backgroundView?.contentMode = .scaleAspectFill
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { maker in
            maker.top.leading.equalToSuperview().offset(20)
            maker.width.equalToSuperview().dividedBy(3)
        }

        vStackView.addArrangedSubview(ownerName)
        vStackView.addArrangedSubview(likes)
        vStackView.addArrangedSubview(likeButton)
        
        likeButton.snp.makeConstraints { maker in
            maker.width.height.equalTo(25)
        }
        
        likeButton.addTarget(self, action: #selector(toggleLike(_:)), for: .touchUpInside)
    }
    
    func configure(photo: Photo) {
        
        viewModel = SearchCellViewModel(photo: photo)
        backgroundView = nil
        viewModel?.photo.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] photo in

                self?.backgroundView = photo.photo
                self?.ownerName.text = photo.user.name
                self?.likes.text = String(photo.likes)
                self?.liked = photo.liked_by_user
                
                self?.likeButton.setImage(
                    UIImage(systemName: photo.liked_by_user ? "bolt.heart.fill" : "bolt.heart")!,
                    for: .normal
                )

            }).disposed(by: disposeBag)
    }
    
    @objc func toggleLike(_ sender: UIButton) {
        liked ? viewModel?.unlike() : viewModel?.like()
        
    }
}
