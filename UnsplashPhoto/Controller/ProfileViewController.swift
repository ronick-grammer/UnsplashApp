//
//  ProfileViewController.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/07.
//

import Foundation
import UIKit
import SnapKit

class ProfileViewController: UICollectionViewController {
    
    private let cellIdentifier = "ProfileCell"
    private let headerIdentifier = "ProfileHeader"
    
    private var isLoggedIn = true
    
    private var barButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = "로그아웃"
        
        return barButtonItem
    }()
    
    private var loginImage: UIImageView = {
        var imageView = UIImageView(image: UIImage(systemName: "lock")!)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var loginButton: UIButton = {
        var button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.tintColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    private var loginLabel: UILabel = {
        var label = UILabel()
        label.text = "이 필요한 서비스입니다."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var vStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var hStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Profile"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        // top Spacing 
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        setUpLoginRequestLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if isLoggedIn { // 로그인 상태이면 사진목록과 로그아웃 버튼 활성화
            collectionView.delegate = self
            collectionView.dataSource = self
            navigationItem.rightBarButtonItem = barButton
            vStackView.isHidden = true
        } else { // 로그아웃 상태이면 사진목록과 로그아웃 버튼 비활성화
            collectionView.delegate = nil
            collectionView.dataSource = nil
            navigationItem.rightBarButtonItem = nil
            vStackView.isHidden = false
        }
        
    }
    
    private func setUpLoginRequestLayout() {
        view.addSubview(vStackView)
        
        vStackView.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
        }
        
        vStackView.addArrangedSubview(loginImage)
        vStackView.addArrangedSubview(hStackView)
        hStackView.addArrangedSubview(loginButton)
        hStackView.addArrangedSubview(loginLabel)
        
        loginImage.snp.makeConstraints { maker in
            maker.height.width.equalTo(50)
        }
    }

}


// MARK: - UICollectionViewDelegate
extension ProfileViewController{
    
}

// MARK: - UICollectionViewDataSource
extension ProfileViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProfileCell
        
        cell.configure(photo: UIImage(named: "restaurant_1")!, name: "Kevin", likes: 24)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        
        header.configure(profileImage: UIImage(named: "restaurant_1")!, name: "Ronick Kim")
        
        return header
        
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 30
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width - 30) / 2
        
        return CGSize(width: width, height: width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let width = collectionView.frame.width
        
        return CGSize(width: width, height: 130)
    }
}


#if DEBUG
import SwiftUI

struct ProfileViewController_Preview: PreviewProvider {
    
    static var previews: some View {
        
        UIViewControllerPreview {
            
            let vc =  ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
            
            vc.collectionView.backgroundColor = .white
            let nav = UINavigationController(rootViewController: vc)
            
            
            return nav
            
        }
        
    }
    
}

#endif
