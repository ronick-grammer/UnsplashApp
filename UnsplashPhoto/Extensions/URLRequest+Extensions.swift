//
//  URLRequest+Extensions.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/09.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    
    static func load<T>(resource: Resource<T>) -> Observable<T> {
        
        return URLSession.shared.rx.data(request: URLRequest(url: resource.url))
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
    
}
