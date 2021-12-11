//
//  SearchViewModel.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/09.
//

import Foundation
import RxSwift

class SearchViewModel {
    var photos = PublishSubject<[Photo]>()
    let disposeBag = DisposeBag()
    
    init() {
        searchImage(query: "Nature")
    }
    
    func searchImage(query: String) {
        
        guard let url = URL.urlForSearchPhotosAPI(query: query) else { return }
        let resource = Resource<PhotoResults>(url: url)
        URLRequest.load(resource: resource)
            .subscribe(onNext: { [weak self] photoResults in
                
                self?.photos.onNext(photoResults.results)
                
            }).disposed(by: disposeBag)
    }

}
