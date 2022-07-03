//
//  URL+Extensions.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/09.
//

import Foundation

// MARK: - API URL 모음
extension URL {
    
    static let base_url = "https://api.unsplash.com"
    
    static let access_key = "-QicJj3Ux8TOcMPwQ2W9tzr_hQx8cJyjMIZMcNpK1sM"

    static let redirect_uri = "ronick.UnsplashPhotoApp://callback"
    
    static let secret_key = "DZ1QT-0B2V5Dus46u7_hguKGw92PUbDshIyCEGlrHdo"
    
    static let scope = "public+write_likes"
    
    static func urlForSearchPhotosAPI(query: String, page: Int, perPage: Int) -> URL? {
        return URL(string: "\(base_url)/search/photos?client_id=\(access_key)&page=\(page)&query=\(query)&per_page=\(perPage)")
    }
    
    static func urlForPhoto(photoID: String) -> URL? {
        return URL(string: "\(base_url)/photos/\(photoID)?client_id=\(access_key)")
    }
    
    static func urlForLogin() -> URL? {
        
        guard let redirect_uri = URL.redirect_uri.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("Invalid encoding..!")
            return nil
        }
        
        print("redirect_uri: ", redirect_uri)
        return URL(string: "https://unsplash.com/oauth/authorize?client_id=\(access_key)&redirect_uri=\(redirect_uri)&response_type=code&scope=\(scope)")
    }
    
    static func urlForAccessToken() -> URL? {
        return URL(string: "https://unsplash.com/oauth/token")
    }
    
    static func urlForUserPrivateProfile() -> URL? {
        return URL(string: "\(base_url)/me")
    }
    
    static func urlForUserPublicProfile(username: String) -> URL? {
        return URL(string: "\(base_url)/users/\(username)?client_id=\(access_key)")
    }
    
    static func urlForLikePhoto(photoID: String) -> URL? {
        return URL(string: "\(base_url)/photos/\(photoID)/like")
    }
    
    static func urlForLikedPhotos(username: String) -> URL? {
        return URL(string: "\(base_url)/users/\(username)/likes")
    }
    
}
