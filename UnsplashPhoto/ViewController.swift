//
//  ViewController.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/06.
//

import UIKit
import RxSwift

class ViewController: UITabBarController {
    
    let disposeBag = DisposeBag()
    
    private var barButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = "로그인"
        
        return barButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 탭뷰 설정
        let search = templateTabViewController(vc: SearchViewController(), unselectedImage: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass.fill") )
        
        let profile = templateTabViewController(vc: ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout()), unselectedImage: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        let viewController = [search, profile]
        
        setViewControllers(viewController, animated: false)
        
        tabBar.tintColor = .black
        
        setUpBarButton()
    }
    
    func templateTabViewController(vc: UIViewController, unselectedImage: UIImage?, selectedImage: UIImage?) -> UIViewController {
        
        vc.tabBarItem.image = unselectedImage
        vc.tabBarItem.selectedImage = selectedImage
        return vc
    }
    
    private func setUpBarButton() {
        
        self.navigationItem.rightBarButtonItem = barButton
        barButton.title = "로그인"
        barButton.target = self
        barButton.action = #selector(btn_login)
        AuthManager.shared.loggedIn
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] loggedIn in
                if loggedIn { // 로그인 상태이면 로그아웃 버튼 활성화
                    self?.barButton.title = "로그아웃"
                    self?.barButton.action = #selector(self?.btn_logout)
                } else { // 로그아웃 상태이면 로그인 버튼 활성화
                    self?.barButton.title = "로그인"
                    self?.barButton.action = #selector(self?.btn_login)
                }
            }).disposed(by: disposeBag)
    }
    
    @objc func btn_login() {
        guard let url = URL.urlForLogin() else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func btn_logout() {
        AuthManager.shared.signOut()
    }
    
}


// MARK: - UI PreView
#if canImport(SwiftUI) && DEBUG

import SwiftUI

struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    
    let viewController: ViewController
    
    init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
        
    }
    
    func makeUIViewController(context: Context) -> ViewController {
        return viewController
        
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
        viewController.view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        viewController.view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
    }
}


struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View

    init(_ builder: @escaping () -> View) {
        view = builder()
    }

    // MARK: - UIViewRepresentable

    func makeUIView(context: Context) -> UIView {
        return view
    }

    func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
    }
}
#endif


