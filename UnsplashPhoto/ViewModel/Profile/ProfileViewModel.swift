//
//  ProfileViewModel.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/13.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel {
    var likedPhotos = BehaviorRelay<[Photo]>(value: [])
    let disposeBag = DisposeBag()
    
    init() {
        fetchLikedPhotos()
    }
    
    func fetchLikedPhotos() {
        guard let username = AuthManager.shared.user?.username else { return }
        guard let accessCode = AuthManager.shared.token else { return }
        guard let url = URL.urlForLikedPhotos(username: username) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessCode)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.rx.data(request: request)
            .map { data -> [Photo] in
                return try JSONDecoder().decode([Photo].self, from: data)
            }.subscribe(onNext: { [weak self] photos in
                self?.likedPhotos.accept(photos)
            }).disposed(by: disposeBag)
    }
}
