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
        let fetchPhotoes: Observable<Void> // 로그인 후, 좋아요 상태 체크를 위하여
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
        var fetch = false
        
        input.searchQuery
            .bind(onNext: { query = $0 ?? "Nature" })
            .disposed(by: disposeBag)
        
        input.didScroll.subscribe(onNext: { (contentOffsetY, contentSizeHeight, viewFrameHeight) in
            if !scrolledToEnd && contentOffsetY > contentSizeHeight - viewFrameHeight {
                scrolledToEnd = true
                try? input.page.onNext(input.page.value() + 1)
            }
        }).disposed(by: disposeBag)
        
        input.searchButtonClicked
            .bind {
                photoElements.removeAll()
                scrolledToEnd = false
                input.page.onNext(1)
            }
            .disposed(by: disposeBag)
        
        input.fetchPhotoes
            .bind {
                fetch = true
            }
            .disposed(by: disposeBag)
        
        let pageObservable = input.page.asObservable()
            .skip(1)
            .flatMap { _ -> Observable<Void> in
                return Observable.just(())
            }
        
        let source = Observable.of(input.initialize.asObservable(), pageObservable, input.fetchPhotoes.asObservable())
        
        photoes = source.merge()
            .flatMap { _ -> Observable<PhotoResults> in
                if fetch {
                    return self.searchService.searchImage(query: query.isEmpty ? "Nature" : query, page: 1, perPage: try input.page.value() * 10)
                } else {
                    return self.searchService.searchImage(query: query.isEmpty ? "Nature" : query, page: try input.page.value(), perPage: 10)
                }
            }.map { photoResults -> [Photo] in
                scrolledToEnd = false
                
                if fetch {
                    photoElements = photoResults.results 
                    fetch = false
                } else {
                    photoElements = photoElements + photoResults.results
                }
                
                return photoElements
            }
        
        return Output(searchedPhotoes: photoes)
    }
}
