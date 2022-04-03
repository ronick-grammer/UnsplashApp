//
//  SearchViewModelTests.swift
//  UnsplashPhotoTests
//
//  Created by RONICK on 2022/03/25.
//

import XCTest
@testable import UnsplashPhoto
import RxSwift
import RxCocoa
import RxBlocking
import RxTest
import Nimble

class SearchViewModelTests: XCTestCase {
    
    var sut: SearchViewModel!
    let disposeBag = DisposeBag()
    private var searchController = UISearchController()
    
    private var searchViewModel = SearchViewModel()
    
//    let buttonClicked = ControlEvent<Void>(events: Observable<Void>.just(()))
    let searchButtonClicked = PublishSubject<Void>()
    let searchQuery = PublishSubject<String?>()
    
    lazy var input = SearchViewModel.Input(
        initialize: BehaviorSubject<Void>.init(value: Void()),
        searchButtonClicked: searchButtonClicked.asObservable(),
        searchQuery: searchQuery.asObservable(),
        page: BehaviorSubject<Int>.init(value: 1),
        didScroll: Observable.just((300, 700, 730))
    )
    
    lazy var output = searchViewModel.transform(input: input)

    override func setUp() {
        super.setUp()
        sut = SearchViewModel()
        
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_test() {

        let s = TestScheduler(initialClock: 0)
        let ob = s.createHotObservable([
            .next(1, "a"),
            .next(2, "b")
        ])

        let observer = s.createObserver(String.self)
        ob.subscribe(observer).disposed(by: disposeBag)

        s.start()

        expect(observer.events).to(equal([.next(1, "a"), .next(2, "b")]))
    }
    
    

}
