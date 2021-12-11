//
//  Authorization.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/11.
//

import Foundation

struct AuthorizationRequest: Encodable {
    
    private let client_id: String
    private let client_secret: String
    private let redirect_uri: String
    private let code: String
    private let grant_type: String
    
    init(client_id: String, client_secret: String, redirect_url: String, code: String, grant_type: String) {
        self.client_id = client_id
        self.client_secret = client_secret
        self.redirect_uri = redirect_url
        self.code = code
        self.grant_type = grant_type
    }
}
