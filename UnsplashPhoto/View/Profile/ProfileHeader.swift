//
//  ProfileHeader.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/07.
//

import Foundation
import UIKit
import SnapKit

class ProfileHeader: UICollectionReusableView {
    
    private var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var profileName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: label.font.fontName, size: 25)
        
        return label
    }()
    
    private var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        
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
        addSubview(hStackView)
        
        hStackView.addArrangedSubview(profileImage)
        hStackView.addArrangedSubview(profileName)
        
        hStackView.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
        }
        
        profileImage.snp.makeConstraints { maker in
            maker.width.height.equalTo(snp.height).offset(-10)
        }
    }
    
    func configure(profileImage: UIImage, name: String) {
        self.profileImage.image = profileImage
        self.profileName.text = name
    }
}


#if DEBUG
import SwiftUI

struct ProfileHeader_Preview: PreviewProvider {
    
    static var previews: some View {
        
        UIViewPreview {
            
            let view = ProfileHeader()
            view.configure(profileImage: UIImage(named: "restaurant_1")!, name: "Ronick")
            
            return view
        }.previewLayout(.fixed(width: 300, height: 100))
        
    }
    
}

#endif