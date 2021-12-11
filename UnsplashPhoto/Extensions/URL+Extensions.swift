//
//  URL+Extensions.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/09.
//

import Foundation

extension URL {
    
    static let base_url = "https://api.unsplash.com"
    
    static let access_key = "-QicJj3Ux8TOcMPwQ2W9tzr_hQx8cJyjMIZMcNpK1sM"

    static let redirect_uri = "ronick.UnsplashPhoto://callback"
    
    static let secret_key = "DZ1QT-0B2V5Dus46u7_hguKGw92PUbDshIyCEGlrHdo"
    
    static func urlForSearchPhotosAPI(query: String) -> URL? {
        return URL(string: "\(base_url)/search/photos?client_id=\(access_key)&page=1&query=\(query)" )
    }
    
    static func urlForLogin() -> URL? {
        
        guard let redirect_uri = URL.redirect_uri.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("Invalid encoding..!")
            return nil
        }
        
        print("redirect_uri: ", redirect_uri)
        return URL(string: "https://unsplash.com/oauth/authorize?client_id=\(access_key)&redirect_uri=\(redirect_uri)&response_type=code")
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
}
