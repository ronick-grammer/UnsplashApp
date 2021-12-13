//
//  AuthViewModel.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/11.
//

import Foundation
import RxSwift

class AuthManager {
    
    static var shared = AuthManager()
    
    var token: String?
    
    var loggedIn = PublishSubject<Bool>()
    var loading = PublishSubject<Bool>()
    let disposeBag = DisposeBag()
    
    var user: User?
    
    private init() {
        loggedIn.onNext(false)
    }
    
    func signIn(code authorizationCode: String) {
        
        loading.onNext(true)
        let param = AuthorizationRequest(
            client_id: URL.access_key,
            client_secret: URL.secret_key,
            redirect_url: URL.redirect_uri,
            code: authorizationCode,
            grant_type: "authorization_code"
        )
        guard let paramData = try? JSONEncoder().encode(param) else { return }
        
        guard let url = URL.urlForAccessToken() else { return }
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = paramData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(paramData.count), forHTTPHeaderField: "Content-Length")
        
        // 토큰 얻기에 성공시 토큰 저장과 로그인 여부 토글시키기
        URLSession.shared.rx.data(request: request)
            .map { data -> String in
                try JSONDecoder().decode(AuthorizationResponse.self, from: data)
                    .access_token
            }.subscribe(onNext: { accessToken in
                self.token = accessToken
                
                self.fetchUserProfile(accessToken: accessToken)
            }).disposed(by: disposeBag)
        
    }
    
    private func fetchUserProfile(accessToken: String?) {
        
        guard let accessToken = accessToken else { return }
        guard let url = URL.urlForUserPrivateProfile() else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // username으로 프로필 사진과 이름 얻기
        URLSession.shared.rx.data(request: request)
            .map { data -> String? in
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                else { return nil }
                
                return json["username"] as? String
            }.subscribe(onNext: { username in
                guard let username = username else { return }
                
                self.fetchUser(username: username)
            }).disposed(by: disposeBag)
        
    }
    
    private func fetchUser(username: String) {
        
        guard let url = URL.urlForUserPublicProfile(username: username) else { return }
        
        // 프로필 사진과 이름 얻기
        URLRequest.load(resource: Resource<User>.init(url: url))
            .subscribe(onNext: { user in
                self.user = user
                
                self.loggedIn.onNext(true)
                self.loading.onNext(false)
            }).disposed(by: disposeBag)
        
    }
    
}
