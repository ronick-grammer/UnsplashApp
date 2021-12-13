//
//  User.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/09.
//

import Foundation

struct User: Decodable {
    let username: String
    let name: String
    let profile_image: ProfileImage
}

struct ProfileImage: Decodable {
    let medium: String
}
