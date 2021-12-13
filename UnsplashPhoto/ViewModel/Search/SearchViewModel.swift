//
//  SearchViewModel.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/09.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    var photos = BehaviorRelay<[Photo]>.init(value: [])
    let disposeBag = DisposeBag()
    
    init() {
        searchImage(query: "Nature")
    }
    
    func searchImage(query: String) {
        
        guard let url = URL.urlForSearchPhotosAPI(query: query) else { return }
        let resource = Resource<PhotoResults>(url: url)
        URLRequest.load(resource: resource)
            .subscribe(onNext: { [weak self] photoResults in
                
                self?.photos.accept(photoResults.results)
                
                
            }).disposed(by: disposeBag)
    }

}
