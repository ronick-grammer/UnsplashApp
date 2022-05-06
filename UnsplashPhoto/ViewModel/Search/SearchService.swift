//
//  SearchService.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2022/05/06.
//

import Foundation
import RxSwift

protocol SearchServiceProtocol {
    func searchImage(query: String, page: Int) -> Observable<PhotoResults>
}

class SearchService: SearchServiceProtocol {
    func searchImage(query: String, page: Int) -> Observable<PhotoResults> {
        
        guard let url = URL.urlForSearchPhotosAPI(query: query, page: page) else { return Observable.empty() }
        let resource = Resource<PhotoResults>(url: url)
        
        return URLRequest.load(resource: resource)
    }
}
