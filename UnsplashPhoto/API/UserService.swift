//
//  UserService.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/13.
//

import Foundation
import RxSwift

struct UserService {
    
    static let disposeBag = DisposeBag()
    
    //좋아요
    static func like(photoID: String, completion: @escaping(() -> Void)) {
        
        guard let accessToken = AuthManager.shared.token else { return }
        
        guard let url = URL.urlForLikePhoto(photoID: photoID) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.rx.data(request: request)
            .subscribe(onNext: { _ in
                
                completion()
                
            }).disposed(by: disposeBag)
    }
    
    // 좋아요 취소
    static func unlike(photoID: String, completion: @escaping(() -> Void)) {
        
        guard let accessToken = AuthManager.shared.token else { return }
        
        guard let url = URL.urlForLikePhoto(photoID: photoID) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.rx.data(request: request)
            .subscribe(onNext: { _ in
                
                completion()
                
            }).disposed(by: disposeBag)
    }
    
    // 셀을 로드할 때마다 좋아요 상태를 체크
    static func checkIfUserLikedPhoto(photoID: String, completion: @escaping((_ photoInstance: Photo) -> Void)) {
        
        guard let accessToken = AuthManager.shared.token else { return }
        
        guard let url = URL.urlForPhoto(photoID: photoID) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.rx.data(request: request)
            .map { data -> Photo in
                return try JSONDecoder().decode(Photo.self, from: data)
            }.subscribe(onNext: { photoInstance in
                
                completion(photoInstance)
                
            }).disposed(by: disposeBag)
        
    }
}
