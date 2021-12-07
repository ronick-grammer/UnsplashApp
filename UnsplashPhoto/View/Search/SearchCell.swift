//
//  SearchCell.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/06.
//

import Foundation
import UIKit
import SnapKit

class SearchCell: UITableViewCell {
    
    
    private var ownerName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: label.font.fontName, size: 25)
        label.textColor = .black
        
        return label
    }()
    
    // 좋아요 갯수
    private var likes: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: label.font.fontName, size: 25)
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
        stackView.alignment = .leading
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        backgroundView?.contentMode = .scaleAspectFill
        
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { maker in
            maker.top.leading.equalToSuperview().offset(20)
        }

        vStackView.addArrangedSubview(ownerName)
        vStackView.addArrangedSubview(likes)
        vStackView.addArrangedSubview(likeImage)
        
        likeImage.snp.makeConstraints { maker in
            maker.width.height.equalTo(30)
        }
    }
    
    func configure(photo: UIImage, name: String, likes: Int) {
        backgroundView = UIImageView(image: photo)
        self.ownerName.text = name
        self.likes.text = String(likes)
    }
    
}


// MARK: - Preview

#if DEBUG
import SwiftUI

struct SearchCell_Preview: PreviewProvider {
    
    static var previews: some View {
        
        UIViewPreview {
            let cell = SearchCell()
            
            cell.configure(photo: UIImage(named: "restraurant_1")!, name: "Kevin", likes: 13)
            
            return cell
            
        }.previewLayout(.fixed(width: 500, height: 300))
        
    }
    
}

#endif
