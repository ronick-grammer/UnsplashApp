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
        let page: BehaviorSubject<Int>
        let didScroll: Observable<(contentOffsetY: CGFloat, contentSizeHeight: CGFloat, viewFrameHeight: CGFloat)>
    }
    
    struct Output {
        let searchedPhotoes: Observable<[Photo]>
    }
    
    var disposeBag = DisposeBag()
    
    let searchService: SearchServiceProtocol
    
    init(searchService: SearchServiceProtocol = SearchService()) {
        self.searchService = searchService
    }
    
    
    func transform(input: Input) -> Output {
        
        var photoes:  Observable<[Photo]>
        var photoElements =  [Photo]()
        var query = ""
        var scrolledToEnd = false
        
        input.searchQuery
            .bind(onNext: { query = $0 ?? "Nature" })
            .disposed(by: disposeBag)
        
        input.didScroll.subscribe(onNext: { (contentOffsetY, contentSizeHeight, viewFrameHeight) in
            if !scrolledToEnd && contentOffsetY > contentSizeHeight - viewFrameHeight {
                try? input.page.onNext(input.page.value() + 1)
                scrolledToEnd = true
            }
        }).disposed(by: disposeBag)
        
        input.searchButtonClicked
            .bind {
                photoElements.removeAll()
                input.page.onNext(1)
                scrolledToEnd = false
            }
            .disposed(by: disposeBag)
        
        let pageObservable = input.page.asObservable()
            .flatMap { _ -> Observable<Void> in
                return Observable.just(())
            }.skip(1)
        
        let source = Observable.of(input.initialize.asObservable(), pageObservable)
        photoes = source.merge()
            .flatMap { _ -> Observable<PhotoResults> in
                return self.searchService.searchImage(query: query.isEmpty ? "Nature" : query, page: try input.page.value())
            }.map { photoResults -> [Photo] in
                scrolledToEnd = false
                photoElements = photoElements + photoResults.results
                return photoElements
            }
        
        return Output(searchedPhotoes: photoes)
    }
}
