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
        let initialize: BehaviorSubject<Void>
        let searchButtonClicked: Observable<Void>
        let searchQuery: Observable<String?>
    }
    
    struct Output {
        let searchedPhotoes: Observable<[Photo]>
    }
    
    var disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        var photoes: Observable<[Photo]>
        let searchText = BehaviorRelay<String?>(value: "Nature")
        
        input.searchQuery.subscribe(onNext: { query in
            if let query = query, !query.isEmpty {
                searchText.accept(query)
            }
            
        }).disposed(by: disposeBag)
        
        let source = Observable.of(input.initialize.asObservable(), input.searchButtonClicked)
        photoes = source.merge()
            .flatMap { _ -> Observable<PhotoResults> in
                return self.searchImage(query: searchText.value ?? "Nature")
            }.map { photoResults -> [Photo] in
                return photoResults.results
            }
        
        return Output(searchedPhotoes: photoes)
    }
    
    func searchImage(query: String) -> Observable<PhotoResults> {
        
        guard let url = URL.urlForSearchPhotosAPI(query: query) else { return Observable.empty() }
        let resource = Resource<PhotoResults>(url: url)
        
        return URLRequest.load(resource: resource)
    }
}
