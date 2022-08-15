//
//  Photo.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/09.
//

import Foundation

struct PhotoResults: Decodable {
    let results: [Photo]
}

struct PhotoResult: Decodable {
    let photo: Photo
}

struct Photo: Decodable, Identifiable {
    let id: String
    var likes: Int
    var liked_by_user: Bool
    let user: User
    let urls: PhotoUrl
    
    var photo: WebImageView {
        let webImageView = WebImageView()
        webImageView.imageUrl = urls.regular
        
        return webImageView
    }
}

struct PhotoUrl: Decodable {
    let regular: String
}
