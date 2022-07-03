//
//  SearchService.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2022/05/06.
//

import Foundation
import RxSwift

protocol SearchServiceProtocol {
    func searchImage(query: String, page: Int, perPage: Int) -> Observable<PhotoResults>
}

class SearchService: SearchServiceProtocol {
    func searchImage(query: String, page: Int, perPage: Int) -> Observable<PhotoResults> {
        guard let url = URL.urlForSearchPhotosAPI(query: query, page: page, perPage: perPage) else { return Observable.empty() }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let accessToken = AuthManager.shared.token {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        return URLSession.shared.rx.data(request: request)
            .map { data -> PhotoResults in
                try JSONDecoder().decode(PhotoResults.self, from: data)
            }
    }
}
