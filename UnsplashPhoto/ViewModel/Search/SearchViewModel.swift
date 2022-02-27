//
//  SearchViewModel.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/09.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: ViewModelType {
    
    
    struct Input {
        let searchButtonClicked: Observable<Void>
        let searchQuery: Observable<String?>
    }
    
    struct Output {
        let searchedPhotoes: Observable<[Photo]>
    }
    
    var photos = BehaviorRelay<[Photo]>.init(value: [])
    var disposeBag = DisposeBag()
    
    init() {
//        searchImage(query: "Nature")
    }
    
    func transform(input: Input) -> Output {
        
        var photoes: Observable<[Photo]>
        let searchText = BehaviorRelay<String?>(value: "Nature")
        
        input.searchQuery.bind(to: searchText).disposed(by: disposeBag)
        
        photoes = input.searchButtonClicked
            .flatMap { _ -> Observable<PhotoResults> in
                return self.searchImage(query: searchText.value ?? "nature")
            }.map { photoresults -> [Photo] in
                return photoresults.results
            }
            
        return Output(searchedPhotoes: photoes)
    }
    
    func searchImage(query: String) -> Observable<PhotoResults> {
        
        guard let url = URL.urlForSearchPhotosAPI(query: query) else { return Observable.empty() }
        let resource = Resource<PhotoResults>(url: url)
        
        return URLRequest.load(resource: resource)
    }
    
//    func searchImage(query: String) -> [Photo]{
//
//        guard let url = URL.urlForSearchPhotosAPI(query: query) else { return }
//        let resource = Resource<PhotoResults>(url: url)
//        URLRequest.load(resource: resource)
//            .subscribe(onNext: { [weak self] photoResults in
//
//                self?.photos.accept(photoResults.results)
//
//
//            })
//            .disposed(by: disposeBag)
//    }

}




//class SearchViewModel{
//
//    var photos = BehaviorRelay<[Photo]>.init(value: [])
//    let disposeBag = DisposeBag()
//
//    init() {
//        searchImage(query: "Nature")
//    }
//
//    func searchImage(query: String) {
//
//        guard let url = URL.urlForSearchPhotosAPI(query: query) else { return }
//        let resource = Resource<PhotoResults>(url: url)
//        URLRequest.load(resource: resource)
//            .subscribe(onNext: { [weak self] photoResults in
//
//                self?.photos.accept(photoResults.results)
//
//
//            }).disposed(by: disposeBag)
//    }
//
//}
//
