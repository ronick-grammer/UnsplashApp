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
    
    func transform(input: Input) -> Output {
        
        var photoes:  Observable<[Photo]>
        var photoElements =  [Photo]()
        var query = ""
        var scrolledToEnd = false
        
        input.searchQuery
            .bind(onNext: { query = $0 ?? "Nature" })
            .disposed(by: disposeBag)
        
        // TODO: - 스크롤해서 가장 아래로 내려갔을때 photoes 배열에 다음 사진들 더해주기, 다음 사진을 가져오면 scrolledtoEnd를 false로 바꿔주기
        input.didScroll.subscribe(onNext: { (contentOffsetY, contentSizeHeight, viewFrameHeight) in
            if !scrolledToEnd && contentOffsetY > contentSizeHeight - viewFrameHeight {
                try? input.page.onNext(input.page.value() + 1)
                scrolledToEnd = true
            }
        }).disposed(by: disposeBag)
        
        input.searchButtonClicked
            .bind {
                input.page.onNext(1)
                photoElements.removeAll()
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
                return self.searchImage(query: query.isEmpty ? "Nature" : query, page: try input.page.value())
            }.map { photoResults -> [Photo] in
                scrolledToEnd = false
                photoElements = photoElements + photoResults.results
                return photoElements
            }
        
        return Output(searchedPhotoes: photoes)
    }
    
    func searchImage(query: String, page: Int) -> Observable<PhotoResults> {
        
        guard let url = URL.urlForSearchPhotosAPI(query: query, page: page) else { return Observable.empty() }
        let resource = Resource<PhotoResults>(url: url)
        
        return URLRequest.load(resource: resource)
    }
}
