//
//  AuthorizationResponse.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/12.
//

import Foundation

struct AuthorizationResponse: Decodable {
    let access_token: String
    let token_type: String
    let scope: String
    let created_at: Int
}
