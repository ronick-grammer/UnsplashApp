//
//  ProfileViewController.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/07.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class ProfileViewController: UICollectionViewController {
    
    private var viewModel = ProfileViewModel()
    private let disposeBag = DisposeBag()
    
    private let cellIdentifier = "ProfileCell"
    private let headerIdentifier = "ProfileHeader"
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        indicator.center = view.center
        indicator.color = .black
        indicator.style = .large
        indicator.hidesWhenStopped = true
        return indicator
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
        
        collectionView.allowsSelection = false
        view.backgroundColor = .red
        collectionView.delegate = self
        collectionView.dataSource = self
        vStackView.isHidden = false
        
        collectionView.backgroundColor = .white
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        // top Spacing 
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        setUpLoginRequestLayout()
        
        // 로그인 처리 로딩 표시
        AuthManager.shared.loading.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] loading in
                if loading {
                    self?.indicator.startAnimating()
                } else {
                    self?.indicator.stopAnimating()
                }
            }).disposed(by: disposeBag)
        
        // 로그인, 로그아웃 상태에 따라 화면 세팅
        AuthManager.shared.loggedIn.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] loggedIn in
                if loggedIn { // 로그인 상태이면 사진목록과 로그아웃 버튼 활성화
                    self?.collectionView.delegate = self
                    self?.collectionView.dataSource = self
                    self?.vStackView.isHidden = true
                    self?.viewModel.fetchLikedPhotos()
                } else { // 로그아웃 상태이면 사진목록과 로그아웃 버튼 비활성화
                    self?.collectionView.delegate = nil
                    self?.collectionView.dataSource = nil
                    self?.vStackView.isHidden = false
                }
                
                self?.collectionView.reloadData()
                
            }).disposed(by: disposeBag)
        
        viewModel.likedPhotos.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            }).disposed(by: disposeBag)
        
        loginButton.addTarget(self, action: #selector(btn_login), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.topItem?.title = "Profile"
        viewModel.fetchLikedPhotos()
        
    }
    
    private func setUpLoginRequestLayout() {
        view.addSubview(vStackView)
        
        vStackView.snp.makeConstraints { maker in
//            maker.center.equalToSuperview()
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().offset(-50)
        }
        
        vStackView.addArrangedSubview(loginImage)
        vStackView.addArrangedSubview(hStackView)
        hStackView.addArrangedSubview(loginButton)
        hStackView.addArrangedSubview(loginLabel)
        
        loginImage.snp.makeConstraints { maker in
            maker.height.width.equalTo(50)
        }
        
        view.addSubview(indicator)
        indicator.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().offset(-50)
        }
    }
    
    @objc func btn_login() {
        guard let url = URL.urlForLogin() else { return }
        UIApplication.shared.open(url)
    }

}


// MARK: - UICollectionViewDelegate
extension ProfileViewController{
    
}

// MARK: - UICollectionViewDataSource
extension ProfileViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewModel.likedPhotos.value.count

    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProfileCell
        
        cell.configure(photo: viewModel.likedPhotos.value[indexPath.row])

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        
        AuthManager.shared.loggedIn.observeOn(MainScheduler.instance)
            .subscribe(onNext: { loggedIn in
                if loggedIn {
                    guard let user = AuthManager.shared.user else { return }
                    header.configure(profileImageURL: user.profile_image.medium, name: user.name)
                }
            }).disposed(by: disposeBag)
        
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
